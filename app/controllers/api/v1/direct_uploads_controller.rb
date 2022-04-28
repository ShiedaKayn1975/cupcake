class Api::V1::DirectUploadsController < ActiveStorage::DirectUploadsController
  # before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create, :hello]
  
  def create
    key = build_blob_key
    blob = ActiveStorage::Blob.create! **blob_args, key: key
        
    json_resp = direct_upload_json(blob)

    json_resp[:file_url] = params[:public] == 'true' ?
      File.join(ENV['AWS_CLOUDFRONT_HOST'], key.split('/', 2).last.split('/').map{|p| URI.encode_www_form_component(p) }.join('/')) :
      File.join(request.base_url, 'rails/active_storage/blobs', json_resp['signed_id'], URI.encode_www_form_component(json_resp['filename']))

    render json: json_resp
  end

  def hello
    render json: {
      message: 'hello'
    }
  end

  private

    def build_blob_key
      key = "#{ActiveStorage::Blob.generate_unique_secure_token}"

      if namespace = params[:namespace]
        key = "#{namespace}/#{key}"
      end
      # If file is public then
      #
      # Prepend key with /public-assets
      # Append filename after key
      #
      if params[:public] == 'true'
        key = File.join(ENV['AWS_PUBLIC_ASSETS_FOLDER'], "#{key}_#{blob_args[:filename]}")
      end
      key
    end

    # def direct_upload_json(blob)
    #   blob.as_json(root: false, methods: :signed_id).merge(direct_upload: {
    #     url: blob.service_url_for_direct_upload,
    #     headers: blob.service_headers_for_direct_upload
    #   })
    # end
end