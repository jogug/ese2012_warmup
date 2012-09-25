      require 'test/unit'
      require '../app/module/user'


      # syntax for inheritance
      class UserTest < Test::Unit::TestCase

        def test_user_creation
          user = Client::User.init('Jack')

          assert(user.getCredits == 0,'wow 1 mio dollars')
          assert(user.getCredits == 0,'wow 1 mio dollars')
        end


      end