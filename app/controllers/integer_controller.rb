class IntegerController < ApplicationController
    def show
        # User_id is in the token
        increment = IncrementLog.selectLast(@token_info['id'])

        if increment.nil?
            increment = {id: nil, number: 0, created_at: nil}
        end

        render json: increment.number
    end

    def next
        incrementLog = IncrementLog.selectLast(@token_info['id'])

        increment = 0

        unless incrementLog.nil?
            increment = incrementLog.number + 1
        end

        newIncrementLog = IncrementLog.create(user_id: @token_info['id'], number: increment)

        render json: newIncrementLog.number
    end

    def reset
        if params[:int].to_i < 0
            http_status = 400
            response = {
                errors: {
                    status: 400,
                    title: "The integer to be reseted can't be negative"
                }
            }

            render json: response
            return
        end

        increment = IncrementLog.create(user_id: @token_info['id'], number: params[:int])

        render json: increment.number
    end
end
