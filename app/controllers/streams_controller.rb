class StreamsController < ApplicationController
  def show
    @stream = Stream.find(params[:id])
    default_headers
    duration_headers
    seek_headers

    send_file @stream.path,
      filename: @stream.path.split('/').last,
      type: @stream.content_type,
      status: @status,
      disposition: 'inline',
      stream: 'true',
      buffer_size: 32_768
  end
  # http://stackoverflow.com/questions/6759426/rails-media-file-stream-accept-byte-range-request-through-send-data-or-send-file

  private

  def default_headers
    response.headers['Cache-Control'] = 'public, must-revalidate, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Content-Transfer-Encoding'] = 'binary'
    response.headers['Accept-Ranges'] = 'bytes'
  end

  def duration_headers
    response.headers['Content-Duration'] = response.headers['X-Content-Duration'] =
      @stream.x_content_duration.to_s
  end

  # Handle Seekbar
  def seek_headers
    range_begin = 0
    range_end = @stream.size - 1
    if request.headers['Range']
      @status = :partial_content
      request.headers['Range'].match(/bytes=(?<begin>\d+)-(?<end>\d*)/) do |match|
        range_begin = match[:begin].to_i
        range_end = match[:end].to_i if match[:end].present?
      end

      response.headers['Content-Range'] = "bytes #{range_begin}-#{
        range_end.to_i}/#{@stream.size}"
    else
      @status = :ok
    end
    response.headers['Content-Length'] = (range_end - range_begin).to_s
  end
end
