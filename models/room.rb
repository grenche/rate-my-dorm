class Room
  attr_reader :id
  attr_reader :room_number
  attr_reader :building_id
  attr_reader :floor

  def self.get_by_id(room_id)
    CONN.exec_params("SELECT * FROM rooms WHERE room_id = $1", [room_id]) do |result|
      return Room.new(result[0]["room_id"], result[0]["room_number"], result[0]["building_id"], result[0]["floor"])
    end
  end

  def self.all
    CONN.exec("SELECT * FROM rooms") do |result|
      rooms = []
      result.each do |row|
        rooms << Room.new(row["room_id"], row["room_number"], row["building_id"], row["floor"])
      end
      return rooms
    end
  end

  def get_tags
    query = "SELECT * FROM rooms_tags WHERE room_id = $1"
    CONN.exec_params(query, [@id]) do |result|
      return Tag.new(result[0])
    end
  end

  def rating
    query = "SELECT avg(rating) AS avg FROM rooms WHERE room_id = $1"
    CONN.exec_params(query, [@id]) do |result|
      return result[0]["avg"]
    end
  end

  def tag_agreement_counts(tag_name)
    query = "SELECT agree_count, disagree_count FROM rooms_tags WHERE tag_name = $1, room_id = $2"
    CONN.exec_params(query, [tag_name, @id]) do |results|
      return [results[0]["agree_count"], results[0]["disagree_count"]]
    end
  end

  def tag_agree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO rooms_tags (tag_name, room_id, agree_count) VALUES ($1, $2, 1)"
      CONN.exec_params(query, [tag_name, @id])
    else
      query = "UPDATE rooms_tags SET agree_count = agree_count + 1 WHERE tag_name = $1 AND room_id = $2;"
      CONN.exec_params(query, [tag_name, @id])
    end
  end

  def tag_disagree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO rooms_tags (room_id, tag_name, disagree_count) VALUES ($1, $2, 1)"
      CONN.exec_params(query, [@id, tag_name])
    else
      query = "UPDATE rooms_tags SET disagree_count = disagree_count + 1 WHERE tag_name = $1 AND room_id = $2;"
      CONN.exec_params(query, [tag_name, @id])
    end
  end

  def building
    Building.get_by_id(@building_id)
  end

  def reviews
    Review.get_by_room(@id)
  end

  private
  def initialize(room_id, room_number, building_id, floor)
    @id = room_id
    @room_number = room_number
    @building_id = building_id
    @floor = floor
  end
end
