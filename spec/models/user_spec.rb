require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'ユーザー登録' do
    it 'email、password、password_confirmationが存在すれば登録できること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid  
    end

    context "email" do
      it 'が存在しなければ登録できないこと' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end
    end

    context "password" do
      it 'が存在しなければ登録できないこと' do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end
  
      it 'の文字数が6文以上であれば登録できること' do
        user = FactoryBot.build(:user, password: 123456, password_confirmation: 123456)
        user.valid?
        expect(user).to be_valid
      end
  
      it 'の文字数が6文字未満であれば登録できないこと' do
        user = FactoryBot.build(:user, password: 12345, password_confirmation: 12345)
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end
  
      it 'とpassword_confirmation、が一致しなければ登録できないこと' do
        user = FactoryBot.build(:user, password_confirmation: 'passwoooord')
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end

    context 'name' do
      it 'の文字数が20文字以内であれば有効な状態であること' do
        user = FactoryBot.build(:user, name: '12345678901234567890')
        user.valid?
        expect(user).to be_valid
      end

      it 'の文字数が21文字以上であれば無効な状態であること' do
        user = FactoryBot.build(:user, name: '123456789012345678901')
        user.valid?
        expect(user.errors[:name]).to include('は20文字以内で入力してください')
      end
    end

    context 'company_name' do
      it 'の文字数が50文字以内であれば有効な状態であること' do
        user = FactoryBot.build(:user, company_name: '12345678901234567890123456789012345678901234567890')
        user.valid?
        expect(user).to be_valid  
      end

      it 'の文字数が51文字以上であれば無効な状態であること' do
        user = FactoryBot.build(:user, company_name: '123456789012345678901234567890123456789012345678901')
        user.valid?
        expect(user.errors[:company_name]).to include('は50文字以内で入力してください')  
      end
    end
  end
end
