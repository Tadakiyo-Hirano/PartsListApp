require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:product)).to be_valid
  end

  describe "パーツカタログを登録する" do
    context "型式、カテゴリー、ブランドの" do
      it "全てあれば有効であること" do
        expect(FactoryBot.build(:product)).to be_valid
      end
    end

    context "型式の" do
      it "存在がなければ無効な状態であること" do
        product = FactoryBot.build(:product, model: nil)
        product.valid?
        expect(product.errors[:model]).to include("を入力してください")
      end
      
      it "文字数が50文字以内であれば有効であること" do
        product = FactoryBot.build(:product, model: "12345678901234567890123456789012345678901234567890")
        product.valid?
        expect(product).to be_valid
      end

      it "文字数が50文字以上であれば無効であること" do
        product = FactoryBot.build(:product, model: "123456789012345678901234567890123456789012345678901")
        product.valid?
        expect(product.errors[:model]).to include("は50文字以内で入力してください")
      end
    end

    context "category_idの" do
      it "存在がなければ無効な状態であること" do
        product = FactoryBot.build(:product, category_id: nil)
        product.valid?
        expect(product.errors[:category_id]).to include("を入力してください")
      end

      it "値と同じCategoryモデルのidの値があれば有効であること" do
        FactoryBot.create(:category)
        expect(FactoryBot.build(:product, category_id: 2)).to be_valid
      end

      it "値と同じCategoryモデルのidの値がなければ無効であること" do
        FactoryBot.create(:category)
        product = FactoryBot.build(:product, category_id: 3)
        product.valid?
        expect(product.errors[:base]).to include("カテゴリー選択エラー")
      end

      it "値がマイナスであれば無効な状態であること" do
        FactoryBot.create(:category)
        product =FactoryBot.build(:product, category_id: -1)
        product.valid?
        expect(product.errors[:category_id]).to include("は0以上の値にしてください")
      end

      it "型がstringであれば無効な状態であること" do
        FactoryBot.create(:category)
        product =FactoryBot.build(:product, category_id: "text")
        product.valid?
        expect(product.errors[:category_id]).to include("は数値で入力してください")
      end
    end

    context "brand_idの" do
      it "存在がなければ無効な状態であること" do
        product = FactoryBot.build(:product, brand_id: nil)
        product.valid?
        expect(product.errors[:brand_id]).to include("を入力してください")
      end

      it "値と同じBrandモデルのidの値があれば有効であること" do
        FactoryBot.create(:brand)
        expect(FactoryBot.build(:product, brand_id: 2)).to be_valid
      end

      it "値と同じBrandモデルのidの値がなければ無効であること" do
        FactoryBot.create(:brand)
        product = FactoryBot.build(:product, brand_id: 3)
        product.valid?
        expect(product.errors[:base]).to include("ブランド選択エラー")
      end

      it "値がマイナスであれば無効な状態であること" do
        FactoryBot.create(:brand)
        product =FactoryBot.build(:product, brand_id: -1)
        product.valid?
        expect(product.errors[:brand_id]).to include("は0以上の値にしてください")
      end

      it "型がstringであれば無効な状態であること" do
        FactoryBot.create(:brand)
        product =FactoryBot.build(:product, brand_id: "text")
        product.valid?
        expect(product.errors[:brand_id]).to include("は数値で入力してください")
      end
    end
  end
end