= smartcall sms gem

* http://github.com/agilisto/smartcall

== DESCRIPTION:

Gem to provide sms functionality through the Smartcall Technology Solutions web services. Contact http://www.smartcalltech.co.za for an account.

== FEATURES/PROBLEMS:

== SYNOPSIS:
From code:

require 'smartcall'

api = Smartcall::API.new(<USERNAME>, <PASSWORD>, <CAMPAIGN_ID>, <REFERENCE>)

api.send_message("0825559629", "Hello World")

You can also specify the parameters in a ~/.smartcall file:

# ~/.smartcall

username: <username>

password: <password>

campaign_id: <campaign_id>

reference: <reference>


== COMMAND LINE == 

Once the gem is installed text messages can be sent from the command line:

smartcall 0825559629 "Hello World"

== REQUIREMENTS:


== INSTALL:

sudo gem install agilisto-smartcall