class MessagesController < ApplicationController

  def index
  	@messages = Message.where(:toId => @current_user.id)  	
  end

  def new
  	@message = Message.new
  	@toId = params[:toId]
  	@messages = Message.where(:fromId => @current_user.id, :toId => @toId)
  end

  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.html{}
        format.js{render :layout => false}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def message_params
      params.require(:message).permit(:fromId, :toId, :projectId, :message)
    end

end
