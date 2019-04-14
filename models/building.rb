class Building
  attr_reader :building_name


  def self.get_by_id(building_name)
    CONN.exec_params("SELECT * FROM buildings WHERE building_id = $1", [building_name]) do |result|
      return Building.new(result[0])
    end
  end

  def self.all
    CONN.exec("SELECT * FROM buildings") do |result|
      buildings = []
      result.each do |row|
        buildings << Building.new(row)
      end
      return buildings
    end
  end

  def reviews
    Review.get_by_building(@building_name)
  end

  def get_tags
    query = "SELECT * FROM buildings_tags WHERE building_name = $1"
    CONN.exec_params(query, [@building_name]) do |result|
      return Tag.new(result[0])
    end
  end

  #TODO: make it like for tag_name
  def tag_agree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO buildings_tags (building_name, tag_name, agree_count) VALUES ($1, $2, 1)"
      CONN.exec_params(query, [@building_name, tag_name])
    else
      query = "UPDATE buildings_tags SET agree_count = agree_count + 1 WHERE building_name = $2 AND tag_name = $1"
      CONN.exec_params(query, [@building_name, tag_name])
    end
  end

  def tag_disagree(tag_name)
    tag = Tag.get_by_name(tag_name)

    if tag.nil?
      query = "INSERT INTO buildings_tags (building_name, tag_name, disagree_count) VALUES ($1, $2, 1)"
      CONN.exec_params(query, [@building_name, tag_name])
    else
      query = "UPDATE buildings_tags SET disagree_count = disagree_count + 1 WHERE  AND building_name = $2 AND tag_name = $1"
      CONN.exec_params(query, [@building_name, tag_name])
    end
  end

  private

  def initialize(hash)
    @building_name = hash["building_name"]
  end
end
