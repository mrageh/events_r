class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  HOW_HEARD_OPTIONS = [
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]

  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
