class StreamsController < ApplicationController
  include ActionController::Live
  include StreamingHeaders
  include StreamFile
  before_action :playlist_authenticate!

  def show
    @stream = Stream.find(params[:id])
    setup_headers

    response.status = :partial_content
    stream_file(@stream.path) do |chunk|
      response.stream.write chunk
    end
    response.stream.close
  end

  private

  def playlist_authenticate!
    authenticate_or_request_with_http_basic do |name, token|
      p = Playlist.find_by(name: name)
      p.present? && p.token == token
    end
  end
end
