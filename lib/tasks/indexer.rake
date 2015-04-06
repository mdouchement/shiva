def duration(song)
  info = Mediainfo.new(song)
  match = info.streams.last.parsed_response[:audio]['duration_'].match(/(?<m>\d+)mn (?<s>\d+)s/)
  match[:m].to_i * 60 + match[:s].to_i
end

task indexer: :environment do
  music_directory = ARGV.last
  if music_directory == 'indexer'
    fail 'Bad command! Pattern: bundle exec rake indexer /path/to/my/music/dir'
  end
  fail "#{music_directory} is not a directory" unless File.directory?(music_directory)

  Dir["#{music_directory}/**/*.{opus}"].each do |song|
    stream = Stream.find_by(path: song) || Stream.new(path: song)
    stream.update_attributes!(
      size: File.size(song),
      content_type: 'audio/ogg',
      x_content_duration: duration(song)
    )
    STDOUT.puts "Indexed #{stream[:id]} - #{song}"
  end
end
