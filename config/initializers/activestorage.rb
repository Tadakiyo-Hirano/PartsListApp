# Active StorageのURLを期限付きにする
Rails.application.config.active_storage.resolve_model_to_route = :app_blob

if Rails::VERSION::MAJOR < 7
  ActiveSupport.on_load(:active_storage_blob) do
    module ActiveStorageBlobPatched
      def signed_id(**options)
        self.class.superclass.superclass.instance_method(:signed_id).bind(self).call(purpose: :blob_id, **options)
      end
    end

    ActiveStorage::Blob.prepend(ActiveStorageBlobPatched)
  end
end
