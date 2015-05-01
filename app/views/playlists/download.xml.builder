xml.instruct!(:xml, version: '1.0', encoding: 'UTF-8')
xml.playlist(version: '1', xmlns: 'http://xspf.org/ns/0/') do |p|
  p.trackList do |track_list|
    @playlist.tracks.each do |track|
      track_list.track do |t|
        t.location signed_stream_url(track.stream.id)
        t.creator track.artist
        t.album track.album
        t.title track.title
        t.duration track.stream.duration.seconds.in_milliseconds
      end
    end
  end
end
