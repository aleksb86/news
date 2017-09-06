class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @attachment = Attachment.find(params[:id])

    unless @attachment.nil?
      if params[:thumb]
        content = @attachment.photo.thumb.read
      else
        content = @attachment.photo.read
      end
    else # TODO: fix default image for posts.
      @attachment = Attachment.new
      @attachment.photo = default_url
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
      @post = Post.find(params[:post_id])
      @post.attachments = Attachment.where(post_id: @post.id)
      respond_to do |format|
        format.html
        format.js #{ render "attachments/attachments_list" }
      end
    end
  end
end
