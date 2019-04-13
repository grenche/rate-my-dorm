class Building
  attr_reader :id
  attr_reader :name


  def self.get_by_id(building_id)
    CONN.exec_params("SELECT * FROM buildings WHERE building_id = $1", [building_id]) do |result|
      return Building.new(result[0]["building_id"], result[0]["name"])
    end
  end

  def self.all
    CONN.exec("SELECT * FROM buildings") do |result|
      buildings = []
      result.each do |row|
        buildings << Building.new(row["building_id"], row["name"])
      end
      return buildings
    end
  end

  def reviews
    Review.get_by_building(@id)
  end

  def get_tags
    query = "SELECT * FROM buildings_tags WHERE building_id = $1"
    CONN.exec_params(query, [@id]) do |result|
      return Tag.new(result[0])
    end
  end

  def tag_agree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO buildings_tags (building_id, tag_name, agree_count) VALUES ($1, $2, 1)"
      CONN.exec_params(query, [@id, tag_name])
    else
      query = "UPDATE buildings_tags SET agree_count = agree_count + 1 WHERE tag_name = $1 AND building_id = $2;"
      CONN.exec_params(query, [tag_name, @id])
    end
  end

  def tag_disagree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO buildings_tags (building_id, tag_name, disagree_count) VALUES ($1, $2, 1)"
      CONN.exec_params(query, [@id, tag_name])
    else
      query = "UPDATE buildings_tags SET disagree_count = disagree_count + 1 WHERE tag_name = $1 AND building_id = $2;"
      CONN.exec_params(query, [tag_name, @id])
    end
  end

  private
  def initialize(building_id, name)
    @id = building_id
    @name = name
  end
end
