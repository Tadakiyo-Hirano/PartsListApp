module CategoriesHelper
  def new_category_btn
    unless params[:id]
      link_to new_admins_category_path, remote: true do
        button_tag '新規登録', class: "btn btn-sm btn-original shadow"
      end
    else
      button_tag '新規登録', class: "btn btn-sm btn-outline-secondary shadow", disabled: true
    end
  end

  def delete_category_btn
    unless params[:id]
      button_tag '削除', class: "btn btn-sm btn-danger shadow", form: "delete-category", url: destroy_all_admins_categories_path, method: :delete, data: { disable_with: '送信中', confirm: '選択したカテゴリーを削除しますか？' }
    else
      button_tag '削除', class: "btn btn-sm btn-outline-secondary shadow", disabled: true
    end
  end

  def edit_category_form(category)
    if @category.id == category.id
      render 'edit'
    else
      category.name
    end
  end

  def category_check_box(category)
    if Product.where(category_id: category).first
      check_box_tag '', 'true', false, disabled: true
    else
      check_box_tag 'brands[]',category
    end
  end
end
