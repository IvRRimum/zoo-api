class Post < ActiveRecord::Base
  include RoleAccess

  belongs_to :user
  has_many :notes

  validates :title, :body, presence: true

  accepts_nested_attributes_for :notes, :allow_destroy => true
end
