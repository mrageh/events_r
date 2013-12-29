class Registration < ActiveRecord::Base
  belongs_to :event

  HOW_HEARD_OPTIONS = [
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]

  validates :full_name, presence: true

  validates :email, format: { with: /(\S+)@(\S+)/ }

  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
