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
      self.credits= 100
      self.items = Array.new
    end

    #add an item to the user
    def add_item(itemToAdd)
      itemToAdd.set_owner(self)
      itemToAdd.deactivate
       self.items.push(itemToAdd)
    end

    #an item can be sold
    def activate_item(position)
      self.items.fetch(position).activate
    end

    #create an item
    def create_new_item(name,price)
      item = Client::Item.init(item, price)
      self.add_item(item)
    end

    #return a string of the users objects
    def get_items
        if(self.items.size > 0)
           x='items:'
           self.items.each_with_index {|val, index| x = x + "\n#{index}-#{val.get_name} " }
           return x
        end
        return 'i have no items sorry'
    end


    #has the user this item does he sell it?
    def has_item(item)
      result = false

      if(self.items.size > 0)
        self.items.each {|val|
            if (val.get_name == item.get_name and item.is_active )
              return true
            else
              result = false
            end
        }
      else
        result = false
      end

      return result
    end

    #has the user this item
    def all_items(item)
      result = false

      if(self.items.size > 0)
        self.items.each {|val|
          if (val.get_name == item.get_name  )
            return  true
          else
            result = false
          end
        }
      else
        result = false
      end

      return result
    end

    #user has enough money
    def has_enough_money(item)
      if(self.credits>= item.get_price)
        return true
      else
        puts('get money')
        return false
      end
    end

    #buy an item from a user
    def buy_item(user, item)
        if(self.has_enough_money(item) and user.has_item(item))
            self.get_item(user, item)
            self.pay_amount(user, item.get_price)
        else
            #transaction not possible
        end
    end

    #get an Item from another user
    def get_item(user, item)
      position = user.get_position(item)
      x = user.show_item(position)
      self.add_item(x)
      user.give_away_item(position)
    end

    #get the position of an item
    def get_position (item)
      position = 0
      self.items.each_with_index {|val, index|
        if (val.get_name == item.get_name)
          position = index
        end
      }
      return position
    end

    #show item
    def show_item(position)
      return self.items.fetch(position)
    end

    #lose an object
    def give_away_item(position)
      self.items.delete_at(position)
    end

    #pay an amount of credits to another user
    def pay_amount(user, amount)
      if(self.credits>= amount)
        self.credits= self.credits-amount
        user.receive_credits(amount)
      else
        return 'suddenly you dont have enough money'
      end
    end

    def get_credits
        return self.credits
    end

    def get_name
        return self.name
    end

    def receive_credits(value)
        self.credits= self.credits + value
    end

    def set_name(value)
        self.name= value
    end


    #return a string of this objects attributes
    def to_s
      x = self.name + " " +  self.credits.to_s
      x= x + "\n" + self.get_items
      return x
    end
  end
end