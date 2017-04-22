# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

module Shared::Callbacks
  extend ActiveSupport::Concern

  included do
    before_destroy :remove_activity
  end

  def remove_activity
    activity = PublicActivity::Activity.find_by(trackable_id: id, trackable_type: self.class.to_s)
    activity.destroy if activity.present?
    true
  end

  def update_attachment_resource(attachment_id, attachable_type, attachable_id)
    true if Attachment.update(attachment_id, attachable_type: attachable_type, attachable_id: attachable_id)
  end
end
