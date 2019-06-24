class UsersController < ApplicationController
    
    before_action :authenticate, except: [:create, :login]
    
    def show
        user = User.find(@token_info['id'])

        render json: user
    end
    def create
        http_status = 200

        user = User.create(userParams)
        
        if user.valid?
            response = {
                data: {
                    type: "users",
                    attributes: user,
                    status: 200,
                }
            }
        else
            response = {
                errors: {
                    status: 400,
                    title: "Errors in request parameters",
                    detail: user.errors
                }
            }
            http_status = 400
        end

        render json: response, status: http_status
    end

    def update
        user = User.find(@token_info['id'])
        
        user.update(userParams)
        render json: user
    end
    
    def login
        http_status = 200
        user = User.find_by_email(params[:user][:email])

        if(user.authenticate(userParams[:password]))
            jwt = Tokenizer.encrypt({id: user.id, email: user.email})
            response = {
                data: {
                    type: "login",
                    attributes: {jtw: jwt},
                    status: 200,
                }
            }
        else
            http_status = 400
            response = {
                errors: {
                    status: 400,
                    title: "Email or password are incorrect"
                }
            }
        end

        render json: response, status: http_status
    end

    private
        def userParams 
            params.require(:user).permit(:email,:password)
        end
end
