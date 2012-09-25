module Client
  class Item

    attr_accessor :name, :price , :active

    #constructor
    def self.init ( name , price, active)
      user = self.new
      user.name= name
      user.price= price
    end

    def initialize
      user.active= active
    end

  end
end