require 'rails_helper'

RSpec.describe Brand, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:brand)).to be_valid
  end

  describe "ブランド名を登録する" do
    it "重複したブランド名があれば無効な状態であること" do
      brand1 = FactoryBot.create(:brand)
      
      brand2 = FactoryBot.build(:brand, name: brand1.name)
      brand2.valid?
      expect(brand2.errors[:name]).to include("はすでに存在します")
    end

    context "ブランド名の存在が" do
      it "あれば有効な状態であること" do
        expect(FactoryBot.build(:brand)).to be_valid
      end

      it "なければ無効な状態であること" do
        brand = FactoryBot.build(:brand, name: nil)
        brand.valid?
        expect(brand.errors[:name]).to include("を入力してください")
      end
    end

    context "ブランド名の文字数が" do
      it "20文字以内であれば有効であること" do
        brand = FactoryBot.build(:brand, name: "12345678901234567890")
        expect(brand).to be_valid
      end

      it "20文字以上であれば無効であること" do
        brand = FactoryBot.build(:brand, name: "123456789012345678901")
        brand.valid?
        expect(brand.errors[:name]).to include("は20文字以内で入力してください")
      end
    end
  end
end
