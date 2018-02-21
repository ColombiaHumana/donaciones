class Donator < ApplicationRecord
  before_create :add_slug
  has_attached_file :rut_image, styles: { medium: "800x800>" }, default_url: nil
  has_attached_file :doc_image, styles: { medium: "800x800>" }, default_url: nil
  validates_attachment_content_type :doc_image, :rut_image, content_type: /\Aimage\/.*\z/
  validates_presence_of :firstname, :lastname, :doctype, :document, :amount, :rut_image, :doc_image, :email, :mobilephone, :address
  validates_numericality_of :amount, greater_than_or_equal_to: 50_000, less_than_or_equal_to: 5_000_000_000
  validates_with AttachmentSizeValidator, attributes: :doc_image, less_than: 1.megabytes
  validates_with AttachmentSizeValidator, attributes: :rut_image, less_than: 1.megabytes
  private
  def add_slug
    self.slug = SecureRandom.uuid
  end
end
