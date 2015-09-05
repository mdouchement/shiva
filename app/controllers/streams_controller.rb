class StreamsController < ApplicationController
  include ActionController::Live
  include StreamingHeaders
  include StreamFile
  before_action :playlist_authenticate!

  def show
    @stream = Stream.find(params[:id])

    send("use_#{@stream.track.user.streaming_behavior}")
  end

  private

  def playlist_authenticate!
    authenticate_or_request_with_http_basic do |name, token|
      p = Playlist.find_by(name: name)
      p.present? && p.token == token
    end
  end

  def use_send_file
    send_file @stream.path,
      filename: @stream.path.split('/').last,
      type: @stream.content_type,
      status: @status,
      disposition: 'inline',
      stream: 'true',
      buffer_size: 32_768
  end

  def use_real_stream
    setup_headers

    response.status = :partial_content
    stream_file(@stream.path) do |chunk|
      response.stream.write chunk
    end
    response.stream.close
  end
end
