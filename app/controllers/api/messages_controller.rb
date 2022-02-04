module Api
  class MessagesController < ApplicationController

    def index
      if application_decoded_token
        application = Application.find_by(name: application_decoded_token[0]['name'])
        chat = Chat.find_by(number: params[:chat_no], application_id: application.id)
        messages = Message.where({chat_id: chat.id})
        messages = messages.map {|message| message.attributes.except('id')}
        render json:{messages: messages}
      end
    end

    def contain
      application = Application.find_by(name: application_decoded_token[0]['name'])
      chat = Chat.find_by(number: params[:chat_no], application_id: application.id)
      messages = Message.search(params[:message])
      # messages = messages.map {|message| message.attributes.except('_id', 'sender_id', 'receiver_id', 'chat_id')}
      render json:{messages: messages}
    end

    def show
      if application_decoded_token
          application = Application.find_by(name: application_decoded_token[0]['name'])
          chat = Chat.find_by(number: params[:chat_no], application_id: application.id)
          message = Message.find_by({number: params[:message_no], chat_id: chat.id})
          if message
            render json:{content: message.content}
          else
            render json:{message: 'Message not found'}
          end
      end
    end

    def create
        if application_decoded_token
            application = Application.find_by(name: application_decoded_token[0]['name'])
            chat = Chat.find_by(number: params[:chat_no], application_id: application.id)
            message = chat.messages.new(message_params)
            message.sender_id = params[:user].id
            message.number = chat.messages_created + 1
            if message.save
                render json:{number: message.number}
                chat.update({
                    messages_count: chat.messages_count + 1,
                    messages_created: chat.messages_created + 1
                })
            else
                render json:{message: 'Error'}
            end
        end
    end

    def destroy
      if application_decoded_token
        application = Application.find_by(name: application_decoded_token[0]['name'])
        chat = chat.find_by(number: params[:chat_no], application_id: application.id)
        message = Message.find_by({number: params[:message_no], chat_id: chat.id})
        if message.destroy
          chat.update({messages_count: chat.messages_count - 1})
          render json:{message: 'Message deleted'}
        elsif 
          render json:{message: 'Failed to delete message'}
        end
      end
    end

    def update
      if application_decoded_token
        application = Application.find_by(name: application_decoded_token[0]['name'])
        chat = chat.find_by(number: params[:chat_no], application_id: application.id)
        message = Message.find_by({number: params[:message_no], chat_id: chat.id})
        if message.update({content: params[:content]})
          render json:{message: 'Message updated Successfully'}
        elsif 
          render json:{message: 'Failed to update message'}
        end
      end
    end

    def application_decoded_token
        token = params[:app_token]
        token = token.gsub("-", ".")
        begin
            JWT.decode(token, ENV["TokenSecret"], true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
        end
    end

    private 

    def message_params
        params.permit(:receiver_id, :content)
    end

  end
end