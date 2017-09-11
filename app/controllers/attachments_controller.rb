class AttachmentsController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]

  def show
    unless params[:id] == "noimage"
      attachment = Attachment.find(params[:id])
    else
      attachment = Attachment.new
      attachment.photo = File.open(Attachment.new.photo.default_url)
      attachment.updated_at = Time.utc(2017, 1, 1).in_time_zone
    end

    if params[:thumb]
      content = attachment.photo.thumb.read
    else
      content = attachment.photo.read
    end

    if stale?(etag: content, last_modified: attachment.updated_at.utc, public: true)
      send_data content, type: attachment.photo.file.content_type,
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
