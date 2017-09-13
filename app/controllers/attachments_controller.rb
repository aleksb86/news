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
      flash[:success] = 'destroy_attachment_success'
    else
      flash[:danger] = 'destroy_attachment_error'
    end
  end
end
