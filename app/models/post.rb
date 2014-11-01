class Post < ActiveRecord::Base
  validates :title, :author, presence: true
  
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )
end
