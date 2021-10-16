require 'rails_helper'

RSpec.describe Notice, type: :model do
  let(:notice) { FactoryBot.build(:notice) }

  describe 'お知らせを登録する' do
    context '投稿日、お知らせ内容、表示の存在が' do
      it 'あれば有効な状態であること' do
        expect(notice).to be_valid  
      end

      context '投稿日の' do
        it '存在がなければ無効な状態であること' do
          notice.posted_at = nil
          notice.valid?
          expect(notice.errors[:posted_at]).to include('を入力してください') 
        end
      end

      context 'お知らせ内容の' do
        it '存在がなければ無効な状態であること' do
          notice.text = nil
          notice.valid?
          expect(notice.errors[:text]).to include('を入力してください')  
        end

        it '文字数が300字以内であれば有効な状態であること' do
          notice.text = '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' \
                          '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' \
                          '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
          notice.valid?
          expect(notice).to be_valid  
        end

        it '文字数が300字以上であれば無効な状態であること' do
          notice.text = '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' \
                          '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' \
                          '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901'
          notice.valid?
          expect(notice.errors[:text]).to include('は300文字以内で入力してください')  
        end
      end
      
      context '表示の' do
        it '存在が無ければ無効な状態であること' do
          notice.display = nil
          notice.valid?
          expect(notice.errors[:display]).to include('は一覧にありません')  
        end

        it 'の値がtrueであれば有効な状態であること' do
          notice.display = true
          notice.valid?
          expect(notice).to be_valid 
        end

        it 'の値がfalseであれば有効な状態であること' do
          notice.display = false

          notice.valid?
          expect(notice).to be_valid 
        end
      end
    end
  end
end
