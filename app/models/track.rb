# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  album        :string
#  artist       :string
#  title        :string
#  track_number :string
#  hexdigest    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Track < ActiveRecord::Base
  has_one :stream, dependent: :destroy
end
