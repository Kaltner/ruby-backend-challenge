class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate

    @token_info = nil

    private
        def authenticate
            authenticate_or_request_with_http_token do |token, options|

                decryptedToken = Tokenizer.decrypt(token)

                unless User.exists?(decryptedToken['id'])
                    
                end

                if Date.today.to_time.to_i > decryptedToken['exp']

                end

                @token_info = decryptedToken
                # Return True if everything is fine
                true
            end
        end
end
