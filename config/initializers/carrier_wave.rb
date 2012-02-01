CarrierWave.configure do |config|
	if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'uploads'
  end
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAISRD4VBJLGOSBQ3Q',       # required
    :aws_secret_access_key  => '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',       # required
   
  }
  config.fog_directory  = 'uploads.spotdeal.com'                     # required
 # config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

