module ProductsHelper
  def submit_text
    if controller.action_name == 'new'
      '登録'
    elsif controller.action_name == 'edit'
      '更新'
    end
  end

  def document_link(document)
    if document.attached?
      link_to rails_blob_path(document), target: :_blank, rel: "noopener noreferrer" do
        tag.i(class: 'far fa-file-pdf fa-lg')
      end
    end
  end
end
