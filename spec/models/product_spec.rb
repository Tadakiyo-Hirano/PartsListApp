require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @category = FactoryBot.create(:category)
    @brand = FactoryBot.create(:brand)

    @product = FactoryBot.build(:product)
    @product.category_id = @category.id
    @product.brand_id = @brand.id
    @product.document = fixture_file_upload("#{Rails.root}/spec/test_files/test_parts_list.pdf")
  end

  describe 'パーツカタログを登録する' do
    context '型式、カテゴリー、ブランドの' do
      it '全てがあれば有効であること' do
        expect(@product).to be_valid
      end
    end

    context '型式の' do
      it '存在がなければ無効な状態であること' do
        @product.model = nil

        @product.valid?
        expect(@product.errors[:model]).to include('を入力してください')
      end
      
      it '文字数が50文字以内であれば有効であること' do
        @product.model = '12345678901234567890123456789012345678901234567890'

        @product.valid?
        expect(@product).to be_valid
      end

      it '文字数が50文字以上であれば無効であること' do
        @product.model = '123456789012345678901234567890123456789012345678901'
        
        @product.valid?
        expect(@product.errors[:model]).to include('は50文字以内で入力してください')
      end
    end

    context "category_idの" do
      it '存在がなければ無効な状態であること' do
        @product.category_id = nil

        @product.valid?
        expect(@product.errors[:category_id]).to include('を入力してください')
      end

      it '値に存在しないCategoryモデルのidの値があれば無効であること' do
        @product.category_id = @category.id += 1

        @product.valid?
        expect(@product.errors[:category]).to include('を入力してください')
      end
    end

    context "brand_idの" do
      it '存在がなければ無効な状態であること' do
        @product.brand_id = nil

        @product.valid?
        expect(@product.errors[:brand_id]).to include('を入力してください')
      end

      it '値に存在しないBrandモデルのidの値があれば無効であること' do
        @product.brand_id = @brand.id += 1

        @product.valid?
        expect(@product.errors[:brand]).to include('を入力してください')
      end
    end

    context '添付ファイルの' do
      it '存在が無ければ無効な状態であること' do
        @product.document = nil

        @product.valid?
        expect(@product.errors[:document]).to include('を入力してください')
      end

      it '形式がPDF以外の場合は無効であること' do
        @product.document = fixture_file_upload("#{Rails.root}/spec/test_files/test_image.jpg")

        @product.valid?
        expect(@product.errors[:document]).to include('の形式が正しくありません')
      end

      it 'サイズが10MB以上の場合は無効であること' do
        @product.document = fixture_file_upload("#{Rails.root}/spec/test_files/test_large.pdf")

        @product.valid?
        expect(@product.errors[:document]).to include('のサイズは10MBまでにしてください')  
      end
    end
  end
end
