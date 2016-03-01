class ImageUploader

  def initialize(token, uid)
    @app = VkontakteApi::Client.new(token)
    @uid = uid
  end

  def upload
    upload_img('1.jpg')
  end

  private

  def create_or_first_gofriends
    albums = @app.photos.get_albums(owner_id: @uid)
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

  def upload_img(img_url, format = 'image/jpeg')
    album_id = create_or_first_gofriends.id
    url = get_upload_url(album_id)
    upload = VkontakteApi.upload(url: url, file1: [img_url, format])
    #Need for new api, :aid => :album_id
    upload[:album_id] = upload.delete(:aid)
    @app.photos.save(upload)
  end
end