class UploadImageToGoogleCloudJob < ApplicationJob
  queue_as :default

  def perform(category_id)
    category = Category.find(category_id)

    return unless category.image.attached?

    # Upload the image to Google Cloud Storage or process it here
    category.image.upload

    # Generate the thumbnail variant
    thumbnail_blob = category.image.variant(resize_to_limit: [150, 150]).processed.blob

    # Attach the thumbnail as a separate file
    category.thumbnail.attach(
      io: thumbnail_blob.download, # Download the variant's content
      filename: "thumbnail_#{image.filename}",
      content_type: thumbnail_blob.content_type
    )
  end
end
