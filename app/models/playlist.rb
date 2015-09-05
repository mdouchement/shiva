# == Schema Information
#
# Table name: playlists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_playlists_on_name  (name) UNIQUE
#

class Playlist < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tracks
end
