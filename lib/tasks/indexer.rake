require 'audioinfo'

task indexer: :environment do
  music_directory = ARGV.last
  if music_directory == 'indexer'
    fail 'Bad command! Pattern: bundle exec rake indexer /path/to/my/music/dir'
  end
  fail "#{music_directory} is not a directory" unless File.directory?(music_directory)
  user = User.first

  @hexdigests = {}
  Dir["#{music_directory}/**/*.{opus}"].each do |song|
    @song = song
    @info = AudioInfo.open(song)
    stream = create_stream
    Track.find_or_create_by!(hexdigest: hexdigest).tap do |track|
      track.update_attributes!(track_params.merge(stream: stream, user: user))
    end
    STDOUT.puts "Indexed #{stream[:id]} - #{song}"
  end
end

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
  @hexdigests[@song] ||= Digest::SHA2.file(@song).hexdigest
end
