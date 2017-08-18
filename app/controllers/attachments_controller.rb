class AttachmentsController < ApplicationController
  def show
    @attachment = Attachment.find(params[:id])
    content = @attachment.photo.read
    # TODO: make last_modified:
    # if stale?(etag: content, last_modified: content.updated_at.utc, public: true)
    if stale?(etag: content, public: true)
      send_data content, type: @attachment.photo.file.content_type,
        disposition: "inline"
      expires_in 0, public: true
    end
  end
end
