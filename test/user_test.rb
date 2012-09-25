      require 'test/unit'
      require '../app/module/user'


      # syntax for inheritance
      class UserTest < Test::Unit::TestCase

        def test_user_and_item_creation
          jack = Client::User.init('Jack')
          jack.receive_credits(-100)
          assert(jack.get_credits == 0,'wow 1 mio dollars')
          assert(jack.get_name == 'Jack' ,'who is jack?')

          coke = Client::Item.init('coke',1.25)
          coke.activate
          assert(coke.is_active,'i can be sold')
          assert(coke.get_name == 'coke' ,'Im not coke?')

          #Jack is thirsty
          jack.add_item(coke)
          assert(jack.all_items(coke),'Gee... , where did my coke go?')

          #Jack likes to watch Tv, but definitely is never going to sell it
          tv = Client::Item.init('lovedTv', 999)
          jack.add_item(tv)
          assert(!jack.has_item(tv),"I dont want to sell my TV!")

          #jack wins 1 Million dollar check
          check = Client::Item.init('check', 1000000)
          jack.add_item(check)
          assert(jack.all_items(check), 'jack lost his check')

          #jack loses everything
          jack.give_away_item(0)
          assert(!jack.all_items(coke),'what i threw this away?')
          jack.give_away_item(0)
          assert(!jack.all_items(tv),"where did my TV go?")
          jack.give_away_item(0)
          assert(!jack.all_items(check), 'jack lost his check')        end

        def test_user_interaction
          jack = Client::User.init('jack')
          jack.receive_credits(1000)
          gin = Client::User.init('gin')
          gin.receive_credits(100)
          baileys = Client::User.init('baileys')
          baileys.receive_credits(-100)

           #Shop init
          shop =  Client::User.init('shop')
          check = Client::Item.init('check', 1000000)
          tv = Client::Item.init('Tv', 999)
          coke = Client::Item.init('coke',1.25)
          granny = Client::Item.init('granny',0)
          shop.add_item(tv)
          shop.add_item(check)
          shop.add_item(coke)
          shop.add_item(granny)
          shop.activate_item(0)
          shop.activate_item(1)
          shop.activate_item(2)

          #which items does this shop offer?
          puts(shop.get_items)

          #Jack always wanted a granny  deactivate test
          assert(jack.get_credits == 1100, "no money")
          jack.buy_item(shop,granny)
          assert(!jack.has_item(granny), 'finally jack has a granny')

          #buy test
          jack.buy_item(shop, tv)
          assert(!shop.has_item(tv), 'this tv shouldnt be here')
          assert(jack.all_items(tv), 'Jack should have his tv')
          assert(jack.get_credits == 101, 'too much money has jack')
          assert(shop.get_credits == 1099, 'shop money not right')
          jack.activate_item(0)
           #rebuy/ no money test
          assert(jack.has_item(tv),'jack should')
          baileys.buy_item(jack,tv)
          assert(!baileys.has_item(tv),'oh no he doesnt steal')
          assert(jack.has_item(tv),'jack should')
          #no items test
          choclatesprinklessalt = Client::Item.init('choclatesprinklessalt',0)
           jack.buy_item(shop, choclatesprinklessalt)
          assert(!jack.has_item(choclatesprinklessalt))
          #owner test
          assert(jack.show_item(0).owner.get_name=='jack','what the hell')
          assert(shop.show_item(0).owner.get_name=='shop','what the hell')

          puts(jack.to_s)
        end
      end