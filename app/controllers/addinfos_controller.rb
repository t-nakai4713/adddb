class AddinfosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_addinfo, only: [:edit, :update]


  def edit
  end

  def update
    @addinfo.update(addinfos_params)
    if @addinfo.save
      # 一覧画面へ遷移して"ブログを編集しました！"とメッセージを表示します。
#      redirect_to addresses_path, notice: "アドレス管理簿を更新しました！"
      flash[:info] = "アドレスDBの名称・説明を更新しました"
      redirect_to addresses_path
    else
     # 入力フォームを再描画します。
     render 'edit'
    end
  end


  private
    def addinfos_params
      params.require(:addinfo).permit(:db_name, :db_info)
    end

    def set_addinfo
      @addinfo = Addinfo.find(params[:id])
    end

end
