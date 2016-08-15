# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  message    :text
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Announcement < ActiveRecord::Base
  def self.current
    where("starts_at <= :now and ends_at >= :now", now: Time.zone.now )
  end
end
