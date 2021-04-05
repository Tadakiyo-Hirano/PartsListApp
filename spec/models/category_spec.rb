require 'rails_helper'

RSpec.describe Category, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "カテゴリー名を登録する" do
    before do
      @category = Category.create(
        name: "sample category"
      )
    end

    it "重複したカテゴリー名があれば無効な状態であること" do
      @category

      category = Category.new(
        name: "sample category"
      )
      category.valid?
      expect(category.errors[:name]).to include("はすでに存在します")
    end

    context "カテゴリー名の存在が" do
      it "あれば有効な状態であること" do
        expect(@category).to be_valid
      end

      it "なければ無効な状態であること" do
        category = Category.new(name: nil)
        category.valid?
        expect(category.errors[:name]).to include("を入力してください")
      end
    end

    context "カテゴリー名の文字数が" do
      it "20文字以内であれば有効であること" do
        category = Category.new(
          name: "12345678901234567890"
        )
        expect(category).to be_valid
      end

      it "20文字以上であれば無効であること" do
        category = Category.new(
          name: "123456789012345678901"
        )
        category.valid?
        expect(category.errors[:name]).to include("は20文字以内で入力してください")
      end
    end
  end
end
