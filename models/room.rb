class Room
  attr_reader :room_number
  attr_reader :building_name
  attr_reader :floor

  def self.get_by_id(room_number, building_name)
    CONN.exec_params("SELECT * FROM rooms WHERE room_number = $1 AND building_name", [room_number, building_name]) do |result|
      return Room.new(result[0])
    end
  end

  def self.all
    CONN.exec("SELECT * FROM rooms") do |result|
      rooms = []
      result.each do |row|
        rooms << Room.new(row)
      end
      return rooms
    end
  end

  def get_tags
    query = "SELECT * FROM rooms_tags WHERE room_number = $1 AND building_name = $2"
    CONN.exec_params(query, [@room_number, @building_name]) do |result|
      tags = []
      result.each do |row|
        tags << Tag.new(row)
      end
      return tags
    end
  end

  def rating
    query = "SELECT avg(rating) AS avg FROM rooms WHERE room_number = $1 AND building_name = $2"
    CONN.exec_params(query, [@room_number, @building_name]) do |result|
      return result[0]["avg"]
    end
  end

  def tag_agreement_counts(tag_name)
    query = "SELECT agree_count, disagree_count FROM rooms_tags WHERE tag_name = $1 AND room_number = $2 AND building_name = $3"
    CONN.exec_params(query, [tag_name, @room_number, @building_name]) do |results|
      return [results[0]["agree_count"], results[0]["disagree_count"]]
    end
  end

  def tag_agree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO rooms_tags (tag_name, room_number, building_name, agree_count) VALUES ($1, $2, $3, 1)"
      CONN.exec_params(query, [tag_name, @room_number, @building_name])
    else
      query = "UPDATE rooms_tags SET agree_count = agree_count + 1 WHERE tag_name = $1 AND room_number = $2 AND building_name = $3"
      CONN.exec_params(query, [tag_name, @room_number, @building_name])
    end
  end

  def tag_disagree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO rooms_tags (tag_name, room_number, building_name, disagree_count) VALUES ($1, $2, $3, 1)"
      CONN.exec_params(query, [tag_name, @room_number, @building_name])
    else
      query = "UPDATE rooms_tags SET disagree_count = disagree_count + 1 WHERE tag_name = $1 AND room_number = $2 AND building_name = $3"
      CONN.exec_params(query, [tag_name, @room_number, @building_name])
    end
  end

  def building
    Building.get_by_id(@building_name)
  end

  def reviews
    Review.get_by_room(@room_number, @building_name)
  end

  private

  def initialize(hash)
    @room_number = hash["room_number"]
    @building_id = hash["building_name"]
    @floor = hash["floor"]
  end
end
