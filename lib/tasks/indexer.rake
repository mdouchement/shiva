require 'audioinfo'

task indexer: :environment do
  music_directory = ARGV.last
  if music_directory == 'indexer'
    fail 'Bad command! Pattern: bundle exec rake indexer /path/to/my/music/dir'
  end
  fail "#{music_directory} is not a directory" unless File.directory?(music_directory)

  Dir["#{music_directory}/**/*.{opus}"].each do |song|
    info = AudioInfo.open(song)
    stream = Stream.find_by(path: song) || Stream.new(path: song)
    stream.update_attributes!(
      size: File.size(song),
      content_type: 'audio/ogg',
      x_content_duration: info.length
    )
    STDOUT.puts "Indexed #{stream[:id]} - #{song}"
  end
end
