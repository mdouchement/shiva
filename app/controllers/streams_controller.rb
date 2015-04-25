class StreamsController < ApplicationController
  include ActionController::Live
  include StreamingHeaders
  include StreamFile

  def show
    @stream = Stream.find(params[:id])
    setup_headers

    response.status = 206
    stream_file(@stream.path) do |chunk|
      response.stream.write chunk
    end
    response.stream.close
  end
end
