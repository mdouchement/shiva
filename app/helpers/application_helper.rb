module ApplicationHelper
  def signed_stream_url(id)
    uri = URI(stream_url id)
    "#{uri.scheme}://#{@playlist.name}:#{@playlist.token}@#{uri.host}:#{uri.port}#{uri.path}"
  end
end
