class Tenant < ActiveRecord::Base

  has_many :api_requests

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

end
