require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:category) { FactoryBot.build(:category) }

  describe 'カテゴリー名を登録する' do
    it '重複したカテゴリー名があれば無効な状態であること' do
      category1 = FactoryBot.create(:category)

      category2 = FactoryBot.build(:category, name: category1.name)
      category2.valid?
      expect(category2.errors[:name]).to include('はすでに存在します')
    end

    context 'カテゴリー名の存在が' do
      it 'あれば有効な状態であること' do
        expect(category).to be_valid
      end

      it 'なければ無効な状態であること' do
        category = FactoryBot.build(:category, name: nil)
        category.valid?
        expect(category.errors[:name]).to include('を入力してください')
      end
    end

    context 'カテゴリー名の文字数が' do
      it '20文字以内であれば有効であること' do
        category = FactoryBot.build(:category, name: 'a' * 20)
        expect(category).to be_valid
      end

      it '20文字以上であれば無効であること' do
        category = FactoryBot.build(:category, name: 'a' * 21)
        category.valid?
        expect(category.errors[:name]).to include('は20文字以内で入力してください')
      end
    end
  end
end
