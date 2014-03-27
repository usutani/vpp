# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Vpp::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '4907e86dd707245af397df655f8a269e500ba0a8e449e3f2b289a857f500e19811a5b0f7e818d12acdf8731f94fe692719554baa77cae4eb3902787f262d2735'
