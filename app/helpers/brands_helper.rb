module BrandsHelper
  def new_brand_btn
    unless params[:id]
      link_to new_admins_brand_path, remote: true do
        button_tag '新規登録', class: "btn btn-sm btn-original shadow"
      end
    else
      button_tag '新規登録', class: "btn btn-sm btn-outline-secondary shadow", disabled: true
    end
  end

  def delete_brand_btn
    unless params[:id]
      button_tag '削除', class: "btn btn-sm btn-danger shadow",
                          form: "delete-brand",
                          url: destroy_all_admins_brands_path,
                          method: :delete,
                          data: { disable_with: '送信中', confirm: "選択した#{Brand.human_attribute_name :name}を削除しますか？" }
    else
      button_tag '削除', class: "btn btn-sm btn-outline-secondary shadow", disabled: true
    end
  end

  def edit_brand_form(brand)
    if @brand.id == brand.id
      render 'edit'
    else
      brand.name
    end
  end

  def brand_check_box(brand)
    if Product.where(brand_id: brand).first
      check_box_tag '', true, false, disabled: true
    else
      check_box_tag 'brands[]',brand
    end
  end
end
