class BackgroundsSerializer
  include JSONAPI::Serializer

  attributes :picture

  attribute :picture do |picture|
    {
      source: 'unisplash.com',
      source_logo: picture.logo,
      id: picture.id,
      attributes: {
        image_url: picture.image_url,
        description: picture.description,
      }
    }
  end
end
