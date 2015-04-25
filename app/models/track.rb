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
  has_and_belongs_to_many :playlists
end
