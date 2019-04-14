class Review
  attr_reader :id
  attr_reader :room_number
  attr_reader :building_name
  attr_reader :rating
  attr_reader :comment

  def self.get_by_id(review_id)
    CONN.exec_params("SELECT * FROM reviews WHERE review_id = $1", [review_id]) do |result|
      return Review.new(result[0])
    end
  end

  def self.all()
    CONN.exec("SELECT * FROM reviews") do |result|
      reviews = []
      result.each do |row|
        reviews << Review.new(row)
      end
      return reviews
    end
  end

  def self.get_by_building(building_name)
    query = "SELECT * FROM reviews building_name = $1"
    CONN.exec_params(query, [building_name]) do |result|
      return Review.new(result[0])
    end
  end

  def self.get_by_room(room_number, building_name)
    CONN.exec_params("SELECT * FROM reviews WHERE room_number = $1 AND building_name", [room_number, building_name]) do |result|
      return Review.new(result[0])
    end
  end

  def self.post(room_number, building_name, rating, comment)
    CONN.exec_params("INSERT INTO reviews (room_number, building_name, rating, comment) VALUES ($1, $2, $3, $4)", [room_number, building_name, rating, comment])
        .check
  end

  private

  def initialize(hash)
    @id = hash["review_id"]
    @room_number = hash["room_number"]
    @rating = hash["rating"]
    @comment = hash["comment"]
    @building_name = hash["building_name"]
  end
end