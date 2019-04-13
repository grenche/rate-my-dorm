class Review
  attr_reader :id
  attr_reader :room_id
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

  def self.get_by_building(building_id)
    query = "SELECT * FROM reviews JOIN rooms ON rooms.room_id = reviews.room_id WHERE building_id = $1"
    CONN.exec_params(query, [building_id]) do |result|
      return Review.new(result[0])
    end
  end

  def self.get_by_room(room_id)
    CONN.exec_params("SELECT * FROM reviews WHERE room_id = $1", [room_id]) do |result|
      return Review.new(result[0])
    end
  end

  def self.post(room_id, rating, comment)
    CONN.exec_params("INSERT INTO reviews (room_id, rating, comment) VALUES ($1,$2,$3)", [room_id, rating, comment])
        .check
  end

  private

  def initialize(hash)
    @id = hash["review_id"]
    @room_id = hash["room_id"]
    @rating = hash["rating"]
    @comment = hash["comment"]
  end
end