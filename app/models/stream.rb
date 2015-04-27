# == Schema Information
#
# Table name: streams
#
#  id           :integer          not null, primary key
#  path         :string
#  size         :integer
#  content_type :string
#  duration     :integer
#  hexdigest    :string
#  track_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Stream < ActiveRecord::Base
  belongs_to :track
end
