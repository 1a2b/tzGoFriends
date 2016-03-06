class ImageUploader

  def initialize(id)
    @user = User.find(id)
    @app = VkontakteApi::Client.new(@user.token)
  end

  def upload
    if need_to_post_image?
      upload_img
      update_user_uploads_info
    end
  end

  private

  def need_to_post_image?
    @user.last_post_at.nil? || one_day_ago?(@user.last_post_at)
  end

  def one_day_ago?(time)
    Time.now - Time.parse(time) > 1.day
  end

  def update_user_uploads_info
    @user.update(last_post_at: Time.now)
    @user.update(posted_message_id: @user.message.id) unless @user.message.nil?
  end

  def upload_img(format = 'image/jpeg')
    album_id = first_or_create_gofriends.id
    url = get_upload_url(album_id)

    upload = VkontakteApi.upload(url: url, file1: [img_url, format])
    #Need for new api, :aid => :album_id
    upload[:album_id] = upload.delete(:aid)
    upload[:caption] = caption
    @app.photos.save(upload)
  end

  def img_url
    @user.message.image.path
  end

  def caption
    @user.message.message
  end

  def first_or_create_gofriends
    uid = @user.uid
    albums = @app.photos.get_albums(owner_id: uid)
    album = find_gofriends(albums) || create_gofriends
  end

  def find_gofriends(albums)
    albums['items'].select{ |album| album['title'] == 'gofriends' }.first
  end

  def create_gofriends
    @app.photos.create_album(title: 'gofriends', privacy_view: [:all])
  end

  def get_upload_url(album_id)
    @app.photos.get_upload_server(album_id: album_id).upload_url
  end
end