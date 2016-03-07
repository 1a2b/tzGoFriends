require 'rails_helper'

describe Message, type: :model do
  it { is_expected.to validate_presence_of :image }
  it { should have_attached_file(:image) }
  it { is_expected.to validate_attachment_content_type(:image)
        .allowing('image/jpg', 'image/png', 'image/gif')
        .rejecting('text/plain', 'text/xml')
     }
  it { is_expected.to have_many :users }
end
