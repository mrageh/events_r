class Event < ActiveRecord::Base
  def free?
    price.blank? || price.zero?
  end

  def image_blank?
    image_file_name.blank?
  end

  def self.upcoming
    where("starts_at >= ?", Time.now).order("starts_at")
  end
end
