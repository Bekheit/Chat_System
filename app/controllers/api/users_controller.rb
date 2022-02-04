module Api
    class UsersController < ApplicationController
        before_action :authorized, only: [:auto_login]

        # require 'bunny'
  
        # connection = Bunny.new
        # connection.start

        # channel = connection.create_channel

        # queue = channel.queue('users')

        
        def index
          users = User.all;
          users = users.map {|user| user.attributes.except('id')}
          
          render json:{users: users}
        end
        
        def show
          user = User.find_by(username: params[:id])
          if user
            render json:{user: user}
          else
            render json:{message: 'User Not Found'}
          end
        end
        
        def create
          if username_exist(params[:username])
            return render json:{message: 'Username is already exist'}
          end

          user = User.new(user_params)
          pub = CreateUserPublisher.new(user)
          pub.publish
          render json:{message: 'user created'}
          
        end

        def destroy
            user = User.find_by(username: params[:id])
            if user.destroy
              render json:{message: 'User Deleted'}
            else
              render json:{message: 'Failed To Delete User'}
            end
        end

        def update
          if username_exist(params[:new_username])
            return render json:{message: 'Username is already exist'}
          end
          user = User.find_by(username: params[:id])
          if user.update({username: params[:new_username]})
            render json:{message: 'User Updated Successfully'}
          else
            render json:{message: 'Failed to update user'}
          end
        end

        def login
            user = User.find_by(username: params[:username])

            if user && user.authenticate(params[:password])
              
              Current.user = user
              token = encode_token({user_id: user.id})
              render json: {user: user.attributes.except('id'), token: token}
            else
                render json: {error: "Invalid username or password"}
            end
        end


        def auto_login
            render json: user
        end

        # connection.close

        private

        def user_params
            params.permit(:username, :password)
        end

        def username_exist(username)
          user = User.find_by(username: username)
        end


    end
end