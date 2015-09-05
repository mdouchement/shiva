require 'audioinfo'

module TracksIndexer
  extend ActiveSupport::Concern

  def index_tracks(music_directory)
    @track_hexdigests = {}
    songs = Dir["#{music_directory}/**/*.{opus}"]

    songs.each_with_index do |song, i|
      @song = song
      @info = AudioInfo.open(song)
      stream = create_stream
      Track.find_or_create_by!(hexdigest: hexdigest).tap do |track|
        track.update_attributes!(track_params.merge(stream: stream, user: current_user))
      end

      yield i + 1, songs.length if block_given?

      STDOUT.puts "Indexed #{stream[:id]} - #{song}"
    end
  end

  private

  def create_stream
    Stream.find_or_create_by!(path: @song, hexdigest: hexdigest).tap do |s|
      s.update_attributes!(
        size: File.size(@song),
        content_type: 'audio/ogg',
        duration: @info.length
      )
    end
  end

  def track_params
    params = ActionController::Parameters.new(@info.to_h)
    params.permit(:album, :artist, :title).tap do |whitelisted|
      whitelisted[:track_number] = params[:tracknum]
      whitelisted[:hexdigest] = hexdigest
    end
  end

  def hexdigest
    @track_hexdigests[@song] ||= Digest::SHA2.file(@song).hexdigest
  end
end
