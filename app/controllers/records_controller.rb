class RecordsController < ApplicationController
  def index
    @record = Record.new(flash[:record])
    @user = current_user
    @records = @user.records.page(params[:page]).order(day: "DESC")
    @data = @user.records
  end

  def create
    record = Record.new(record_params)
    record.user_id = current_user.id
    if record.save
      flash[:succeed] = '入力しました'
      redirect_to records_path
    else
      redirect_to :back, flash: {
        record: record,
        error_messages: record.errors.full_messages
      }
    end
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
    redirect_to records_path, flash: { error: '削除しました' }
  end

  private

  def record_params
    params.require(:record).permit(:weight, :user_id, :day)
  end

end
