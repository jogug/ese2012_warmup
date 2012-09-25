require '../app/module/item'
module Client
  class User

    attr_accessor :name, :credits, :items

    #constructor
    def self.init ( name )
      user = self.new
      user.name= name
      user
    end

    # initialize is called automatically
    # when an instance is created"
    def initialize
      self.credits= 0
      self.items = Array.new
    end

    #add an item to the user
    def addItem(itemToAdd)
       self.items.push(itemToAdd)
    end

    #return a list of the users objects
    def getItems
        if(self.items.size > 0)
           return self.items.map{ |i| + i.to_s }.join(",")
        end
        return 'this user no have any items'
    end

    #buy an item from a user
    def buyItem(user, item)
        if(self.credits>= item.price and user.items.include? item)
            self.pay(user, item.price)
            self.getItem(user, item)
        else
            put('where is the money,Item?')
        end
    end

    #getItem from another user
    def getItem(user, item)
       user.items.each_with_index {
         |x, index|
         if (x.name == item.name)
            position = index
         end
       }
       self.addItem(user.items.fetch(position))
       user.items.delete_at(position)
    end

    #pay an amount to another user
    def payAmount(user, amount)
      if(self.credits>= amount)
        self.credits= self.credits-amount
        user.credits= user.credits+amount
      else
        return 'you dont have enough money'
      end
    end

    def getCredits
        x = self.credits
        return x
    end

    def getName
        return self.name
    end

    def setCredits(value)
        self.credits= value
    end

    def setName(value)
        self.name= value
    end


    #return a string of this objects attributes
    def to_s
    end
  end
end