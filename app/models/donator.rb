class Donator < ApplicationRecord
  before_create :add_slug
  has_attached_file :rut_image, default_url: nil, styles: { medium: ['600x400>', :jpg] }
  has_attached_file :doc_image, default_url: nil, styles: { medium: ['600x400>', :jpg] }
  validates_attachment_content_type :doc_image, :rut_image, content_type: %w(image/jpeg image/jpg image/png application/pdf)
  validates :document, format: { with: /\A\d{7,10}\z/ }
  validates_presence_of :firstname, :lastname, :document, :amount, :rut_image, :doc_image, :email, :mobilephone, :address, :job
  validates_numericality_of :amount, greater_than_or_equal_to: 5_000, less_than_or_equal_to: 5_000_000_000
  validates_with AttachmentSizeValidator, attributes: :doc_image, less_than: 5.megabytes
  validates_with AttachmentSizeValidator, attributes: :rut_image, less_than: 5.megabytes
  private
  def add_slug
    self.slug = SecureRandom.uuid
    self.doctype = 'CC'
  end
end
