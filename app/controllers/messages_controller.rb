class MessagesController < ApplicationController

before_action :require_user

  def create
    @message = Message.new(message_params)
    @message.member = current_member
    if @message.save
      ActionCable.server.broadcast 'chatroom_channel', message: render_message(@message),
                                                      member: @message.member.membername
    else
      render 'chatrooms/show'
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
  
  def render_message(message)
    #message partial is in messages/message view
    render(partial: 'message', locals: { message: message })
  end
  
end