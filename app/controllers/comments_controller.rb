class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash[:succeed] = 'コメントを投稿しました'
      redirect_to comment.board
    else
      redirect_to :back, flash: {
        comment: comment,
        error_messages: comment.errors.full_messages
      }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.board, flash: { error: 'コメントが削除されました' }
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :board_id, :comment)
  end
end
