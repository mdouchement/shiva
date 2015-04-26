module StreamFile
  extend ActiveSupport::Concern

  def stream_file(path, chunk_size: 16_384)
    File.open(path, 'rb') do |file|
      file.seek(@range_begin)
      while (chunk = file.read(chunk_size))
        yield chunk
      end
    end
  end
end
