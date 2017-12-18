class Address < ActiveRecord::Base

  belongs_to :user
  belongs_to :addinfo

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      address = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      address.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      address.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["ipadd", "use", "status", "addinfo_id"]
  end



end
