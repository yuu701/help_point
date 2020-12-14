class Request < ApplicationRecord
  validates :request_date, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :point, presence: true
  validates :status, inclusion: { in:[true, false] }
  
  belongs_to :parent
  belongs_to :child
  has_one :apply, dependent: :destroy
  
  def create_request(help, create_request_date)
    self.name = help.name 
    self.description = help.description 
    self.point = help.point 
    self.parent_id = help.parent_id 
    self.child_id = help.child_id
    self.request_date = create_request_date
    self.status = true
  end
end
