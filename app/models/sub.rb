class Sub < ActiveRecord::Base
  validates :moderator, :title, presence: true
  validates :title, uniqueness: true
  
  has_many :post_subs, inverse_of: :sub
  
  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id,
    primary_key: :id    
  )
  
  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )
end
