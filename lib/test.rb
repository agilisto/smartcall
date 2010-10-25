require 'smartcall'

api = Smartcall::API.new('201008', '0646', '581', 'Geely_Guess_the_Price')
api.send_message('0825559629', "Test Message")
