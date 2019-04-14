class Tag
  attr_reader :name

  def self.get_by_name(tag_name)
    CONN.exec_params("SELECT * FROM tags WHERE tag_name = $1", [tag_name]) do |result|
      return nil if result.num_tuples == 0
      return Tag.new(result[0])
    end
  end

  def self.all()
    CONN.exec("SELECT tag_name FROM buildings_tags UNION SELECT tag_name FROM rooms_tags") do |result|
      tags = []
      result.each do |row|
        tags << Tag.new(row)
      end
      return tags
    end
  end

  private

  def initialize(hash)
    @name = hash["tag_name"]
  end
end