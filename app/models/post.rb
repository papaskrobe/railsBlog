class Post < ActiveRecord::Base

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  VALID_URL_REGEX = /\A[a-z0-9"_"]+\z/
  validates :url, presence: true, uniqueness: { case_sensitive: false }, 
                  format: { with: VALID_URL_REGEX }, length: { maximum: 100 }


end
