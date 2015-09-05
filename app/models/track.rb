# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  album        :string
#  artist       :string
#  title        :string
#  track_number :string
#  hexdigest    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tracks_on_album      (album)
#  index_tracks_on_artist     (artist)
#  index_tracks_on_hexdigest  (hexdigest)
#  index_tracks_on_title      (title)
#

class Track < ActiveRecord::Base
  belongs_to :user
  has_one :stream, dependent: :destroy
  has_and_belongs_to_many :playlists
end
