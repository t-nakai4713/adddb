class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
	@addresses = Address.all
	@address = Address.find(1)
  end

#CSVインポート
 def import
    Address.import(params[:file])
    redirect_to addresses_path, notice: "アドレスデータをCSVから読み込みました"
 end

#CSVフォーマットファイルのダウンロード
def downloadformat
  file_name="fileformat.csv"
  filepath = Rails.root.join('public',file_name)
  stat = File::stat(filepath)
  send_file(filepath, :filename => file_name, :length => stat.size, :disposition => 'attachment')
end



def create
      @address = Address.new(addresses_params)
      @address.user = current_user.id
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
    @address.user_id = current_user.id
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
      params.require(:address).permit(:ipadd, :use, :status, :addinfo_id, :user_id)
    end

    def set_address
      @address = Address.find(params[:id])
    end

end
