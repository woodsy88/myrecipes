class ChatroomsController < ApplicationController
before_action :require_user  
  
  def show
    @message = Message.new
    #most_recent is a class method, in message.rb
    @messages = Message.most_recent
  end
  
end