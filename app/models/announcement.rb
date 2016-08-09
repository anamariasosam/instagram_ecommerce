class Announcement < ActiveRecord::Base
  def self.current
    where("starts_at <= :now and ends_at >= :now", now: Time.zone.now )
  end
end
