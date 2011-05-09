require File.join(File.dirname(__FILE__), 'smartcall')

api = Smartcall::API.new('RTones', 'RTones', '693', 'Lillets_test')
api.send_message('0825559629', "Test Message")
