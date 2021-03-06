module StreamingHeaders
  extend ActiveSupport::Concern

  def setup_headers
    default_headers
    duration_headers
    seek_headers
  end

  private

  def default_headers
    response.headers['Cache-Control'] = 'public, must-revalidate, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Content-Transfer-Encoding'] = 'binary'
    response.headers['Accept-Ranges'] = 'bytes'
    response.headers['Content-Disposition'] = 'inline'
    response.headers['Content-Type'] = @stream.content_type
  end

  def duration_headers
    response.headers['Content-Duration'] = response.headers['X-Content-Duration'] =
      @stream.duration.to_s
  end

  # Handle Seekbar
  def seek_headers
    @range_begin = 0
    @range_end = @stream.size - 1
    if request.headers['Range']
      request.headers['Range'].match(/bytes=(?<begin>\d+)-(?<end>\d*)/) do |match|
        @range_begin = match[:begin].to_i
        @range_end = match[:end].to_i if match[:end].present?
      end

      response.headers['Content-Range'] = "bytes #{@range_begin}-#{
        @range_end.to_i}/#{@stream.size}"
    end
    response.headers['Content-Length'] = (@range_end - @range_begin).to_s
  end
end
