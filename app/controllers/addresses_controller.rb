class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
	@addresses = Address.all
  end

 def import
    Address.import(params[:file])
    redirect_to addresses_path, notice: "アドレスデータをCSVから読み込みました"
 end

def create
      @address = Address.new(addresses_params)
   if @address.save
      redirect_to addresses_path, success: "投稿しました！"
   else
     @addresses = Address.all
     render 'index'
   end
  end

  def edit
  end

  def update
    @address.update(addresses_params)
    if @address.save
      # 一覧画面へ遷移して"ブログを編集しました！"とメッセージを表示します。
#      redirect_to addresses_path, notice: "アドレス管理簿を更新しました！"
      flash[:info] = "利用状況を更新しました"
      redirect_to addresses_path
    else
     # 入力フォームを再描画します。
     render 'edit'
    end
  end


  private
    def addresses_params
      params.require(:address).permit(:ipadd, :use, :status, :type,)
    end

    def set_address
      @address = Address.find(params[:id])
    end

end
