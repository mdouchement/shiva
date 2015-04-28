module PlaylistGenerator
  extend ActiveSupport::Concern

  def m3u8_playlist
    '#EXTM3U'.tap do |body|
      @playlist.tracks.each do |track|
        body << "\n\n#EXTINF:#{track.stream.duration}, #{track.artist} - #{track.title}"
        body << "\n#{stream_url(track.stream.id)}"
      end
    end
  end
end
