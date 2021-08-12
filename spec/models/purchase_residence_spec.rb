require 'rails_helper'

RSpec.describe PurchaseResidence, type: :model do

  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.build(:item)
    item.image = fixture_file_upload('app/assets/images/example.png')
    item.save
    @residence = FactoryBot.build(:purchase_residence, user_id: user.id, item_id: item.id)
    sleep 1
  end
  
  describe '購入機能' do
    #正常系
    context '購入できる時' do
      it '全ての存在すれば購入できる' do
        expect(@residence).to be_valid
      end

      it '建物名以外の項目が存在すれば購入できる' do
        @residence.building_name = ''
        expect(@residence).to be_valid
      end
    end

    #異常系
    context '購入できない時' do
      it '郵便番号が空では登録できない' do
        @residence.zip_code = ''
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code can't be blank")
      end

      it '郵便番号が半角英字では登録できない' do
        @residence.zip_code = 'aaa-aaaa'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it '郵便番号にハイフンがなければ登録できない' do
        @residence.zip_code = 0000000
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it '郵便番号が全角数字では登録できない' do
        @residence.zip_code = '０００−００００'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it '郵便番号が全角ひらがなでは登録できない' do
        @residence.zip_code = 'ああああああああああ'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it '郵便番号が全角漢字では登録できない' do
        @residence.zip_code = '阿阿阿阿阿阿阿阿阿阿'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it '郵便番号が全角カタカナでは登録できない' do
        @residence.zip_code = 'アアアアアアアアアア'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが空では登録できない' do
        @residence.prefecture_id = nil
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが1では登録できない' do
        @residence.prefecture_id = 1
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できない' do
        @residence.city = ''
        @residence.valid?
        expect(@residence.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では登録できない' do
        @residence.address = ''
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では登録できない' do
        @residence.phone_number = ''
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では登録できない' do
        @residence.phone_number = '000000000'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では登録できない' do
        @residence.phone_number = '000000000000'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が半角英字では登録できない' do
        @residence.phone_number = 'aaaaaaaaaa'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角数字は登録できない' do
        @residence.phone_number = '００００００００００'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角ひらがなでは登録できない' do
        @residence.phone_number = 'ああああああああああ'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角漢字では登録できない' do
        @residence.phone_number = '阿阿阿阿阿阿阿阿阿阿'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角カタカナでは登録できない' do
        @residence.phone_number = 'アアアアアアアアアア'
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Phone number is invalid")
      end

      it "tokenが空では登録できないこと" do
        @residence.token = nil
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では登録できないこと' do
        @residence.user_id = nil
        @residence.valid?
        expect(@residence.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では登録できないこと' do
        @residence.item_id = nil
        @residence.valid?
        expect(@residence.errors.full_messages).to include("Item can't be blank")
      end
    end 
  end
end
