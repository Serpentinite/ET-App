class BoardsController < ApplicationController
# only以下のメソッドが呼び出される前にset_target_boardを呼び出して@boardに特定のidのBoardオブジェクトを入れる
    before_action :set_target_board, only: %i[show edit update destroy]
    def index
      @boards = Board.bool(params[:tag_id], params[:search])
      @boards = @boards.page(params[:page])
    end
  
    def new
      @board = Board.new(flash[:board])
    end
  
    def create
      board = Board.create(board_params)
      board.user_id = current_user.id
      if board.save
        flash[:succeed] = "「#{board.title}」が作成されました"
        redirect_to board
      else
        redirect_to new_board_path, flash: {
            board: board,
            error_messages: board.errors.full_messages
        }
      end
    end
  
    def show
      @comment = Comment.new(board_id: @board.id)
      @comment.user_id = current_user
    end
  
    def edit
    end
  
    def update
      if @board.update(board_params)
        flash[:succeed] = "「#{@board.title}」の編集が完了しました"
        redirect_to @board
      else
        redirect_to :back, flash: {
          board: @board,
          error_messages: @board.errors.full_messages
        }
      end
    end
  
    def destroy
      if user_signed_in? && current_user.id == @board.user_id
        @board.destroy
        redirect_to boards_path, flash: { error: "「#{@board.title}」が削除されました"}
      else
      redirect_to boards_path, flash: { error: "削除できるのは作成者のみです。"}
      end
    end

    private
  
    def board_params
      params.require(:board).permit(:user_id, :title, :body, tag_ids: [])
    end

    def set_target_board
        @board = Board.find(params[:id])
    end
  end