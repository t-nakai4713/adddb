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
    flash[:info] = "アドレスデータをCSVから読み込みました"
    redirect_to addresses_path
 end

#インポート用CSVファイルの書き方お作法
 def getmanual
    csv_name = "manual.txt"
    csvpath = Rails.root.join('public',csv_name)
    send_file(csvpath , disposition: "attachment")
 end

#CSVフォーマットファイルのDL
 def getformat
    csv_name = "format.csv"
    csvpath = Rails.root.join('public',csv_name)
    send_file(csvpath , disposition: "attachment")
 end




  def edit
  end

  def update
   if params[:DL_button]
	#IPAddr形式のアドレスデータをstringに変換、置換対象の文字列を指定
        tmpipadd = @address.ipadd
        ipadd = tmpipadd.to_s
        ptn = "xipaddx"

        #テキストテンプレートの読み込み
        if @address.status == 0
	        #現在未利用（利用開始する）場合はtext_tpl1を読み込み
	        texttpl = @address.addinfo.text_tpl1
        else
	        #現在利用中（廃止する）場合はtext_tpl2を読み込み
	        texttpl = @address.addinfo.text_tpl2
        end

        #テキストテンプレートの読み込み、文中の文字列をアドレスに置換
        tplpath = Rails.root.join('public',texttpl)
        tpl = File.open(tplpath,"r")
        buffer =tpl.read
        buffer.gsub!(ptn, ipadd)

        #出力用テキストファイルを作成・書き込み 
	textfile = "config.txt"
        textpath = Rails.root.join('public',textfile)
        tmptext = File.open(textpath,"w")
        tmptext.write(buffer)

	#テキストテンプレート、出力用テキストを閉じる
        tpl.close()
        tmptext.close()

	#出力用テキストの保存ダイアログを表示
	send_file(textpath , disposition: "attachment")
	return
   else
    @address.update(addresses_params)
    @address.user_id = current_user.id
    if @address.save
      flash[:info] = "利用状況を更新しました"
      redirect_to addresses_path
      return
    else
     # 入力フォームを再描画します。
     render 'edit'
     return
    end

   end
  end


def downloadtext
	#IPAddr形式のアドレスデータをstringに変換、置換対象の文字列を指定
        tmpipadd = @address.ipadd
        ipadd = tmpipadd.to_s
        ptn = "xipaddx"

        #テキストテンプレートの読み込み
        if @address.status == 0
	        #廃止する場合はtext_tpl2を読み込み
	        texttpl = @address.addinfo.text_tpl2
        else
	        #利用する場合はtext_tpl1を読み込み
	        texttpl = @address.addinfo.text_tpl1
        end

        #テキストテンプレートの読み込み、文中の文字列をアドレスに置換
        tplpath = Rails.root.join('public',texttpl)
        tpl = File.open(tplpath,"r")
        buffer =tpl.read
        buffer.gsub!(ptn, ipadd)

        #出力用テキストファイルを作成・書き込み 
	textfile = "text.txt"
        textpath = Rails.root.join('public',textfile)
        tmptext = File.open(textpath,"w")
        tmptext.write(buffer)

	#テキストテンプレート、出力用テキストを閉じる
        tpl.close()
        tmptext.close()

	#出力用テキストの保存ダイアログを表示
	send_file(textpath , disposition: "attachment")
end




  private
    def addresses_params
      params.require(:address).permit(:ipadd, :use, :status, :addinfo_id, :user_id)
    end

    def set_address
      @address = Address.find(params[:id])
    end

end
