class Tokenizer
  class << self
    API_KEY = Rails.application.config_for(:jwt)['api_key']

    def encrypt(payload, expiration = 7.days.from_now)
      payload[:exp] = expiration.to_i
      JWT.encode(payload, API_KEY)
    end

    def decrypt(token)
      JWT.decode(token, API_KEY)[0]
    end
 end
end