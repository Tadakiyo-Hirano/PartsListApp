module ProductsHelper
  
  def document_link(document)
    if document.attached?
      link_to rails_blob_path(document), target: :_blank, rel: "noopener noreferrer" do
        tag.i(class: 'far fa-file-pdf fa-lg')
      end
    end
  end
end
