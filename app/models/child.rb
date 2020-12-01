class Child < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  
  validates :login_id, presence: true, length: { maximum: 255 },
            uniqueness: { case_sensitive: false }
  
  VALID_PASSWORD_REGEX = /\A(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\z/
  validates :password, presence: true, length: { minimum: 8 }, allow_nil:true,
            format: { with: VALID_PASSWORD_REGEX } 
  
  has_secure_password
  
  belongs_to :parent
  belongs_to :icon
  has_many :helps, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :applies, through: :requests
  has_many :results, dependent: :destroy
  
  def not_closed_applies
    applies.where(close: false).includes(:request)
  end
  
  def on_requests
    requests.where(status: false)
  end
  
  def match_completion_date(date)
    results.where(completion_date: date)
  end
  
  # def total_point(search_date)
  #   point_bonus_arrays = results.where(completion_date: search_date.in_time_zone.all_month).pluck(:point, :bonus)
  #   total_point = 0
  #   point_bonus_arrays.each do |array|
  #     total_point += array.sum
  #   end
  #   return total_point
  # end
  
  # def total_point
  #     if $points
  #       $points.each do |point|
  #         if point["child_id"] == self.id
  #           return point["total_point"]
  #         else
  #           return 0
  #         end
  #       end
  #     else
  #       return 0
  #   end
  # end
  
  def total_point
    if $point_data_hash.has_key?(self.id)
      return $point_data_hash[self.id]
    else
      return 0
    end
  end
end
