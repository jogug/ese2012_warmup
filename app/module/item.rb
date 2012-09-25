module Client
  class Item

    attr_accessor :name, :price , :active , :owner

    #constructor
    def self.init ( name , price)
      item = self.new
      item.name= name
      item.price= price
      item
    end

    def initialize
      self.owner = nil
      self.active= false
    end

    def set_owner(user)
      self.owner = user
    end

    def get_price
        return self.price
    end

    def get_name
        return self.name
    end

    def is_active
      return self.active
    end

    def deactivate
      self.active=false
    end

    def activate
      self.active =true
    end

    def to_s
      return self.name
    end
  end
end