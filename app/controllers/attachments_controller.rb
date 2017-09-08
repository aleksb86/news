class AttachmentsController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]

  def show
    unless params[:id] == "noimage"
      @attachment = Attachment.find(params[:id])
      unless @attachment.nil?
        if params[:thumb]
          content = @attachment.photo.thumb.read
        else
          content = @attachment.photo.read
        end
      end
    else
      content = File.open(Attachment.new.photo.default_url)
      # send_data content.read, type: 'image/png', disposition: "inline"
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
      @post = Post.find(params[:post_id])
      @post.attachments = Attachment.where(post_id: @post.id)
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
