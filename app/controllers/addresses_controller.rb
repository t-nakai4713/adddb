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
      redirect_to addresses_path, notice: "投稿しました！"
   else
     @addresses = Address.all
     render 'index'
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
