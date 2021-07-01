module BrandsHelper
  def new_brand_btn
    unless params[:id]
      link_to new_admins_brand_path, remote: true do
        button_tag '登録', class: "btn btn-sm btn-navy"
      end
    else
      button_tag '登録', class: "btn btn-sm btn-outline-secondary", disabled: true
    end
  end

  def delete_brand_btn
    unless params[:id]
      button_tag '削除', class: "btn btn-sm btn-danger", form: "delete-brand", url: destroy_all_admins_brands_path, method: :delete, data: { disable_with: '送信中', confirm: '選択したカテゴリーを削除しますか？' }
    else
      button_tag '削除', class: "btn btn-sm btn-outline-secondary", disabled: true
    end
  end

  def edit_brand_form(brand)
    if @brand.id == brand.id
      render 'edit'
    else
      brand.name
    end
  end
end
