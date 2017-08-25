class AttachmentsController < ApplicationController

  def show
    @attachment = Attachment.find(params[:id])
    if params[:thumb]
      content = @attachment.photo.thumb.read
    else
      content = @attachment.photo.read
    end

    last_modified = nil
    unless @attachment.updated_at.nil?
      last_modified = @attachment.updated_at.utc
    end

    if stale?(etag: content, last_modified: last_modified, public: true)
      send_data content, type: @attachment.photo.file.content_type,
        disposition: "inline"
      expires_in 0, public: true
    end
  end

  def destroy
    attachment = Attachment.find(params[:id])
    if attachment.destroy
      @posts = Post.all
      respond_to do |format|
        format.html
        format.js { render nothing: true }
      end
    end
  end
end