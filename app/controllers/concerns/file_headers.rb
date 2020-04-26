module FileHeaders
  extend ActiveSupport::Concern

  def csv_stream_headers(filename:)
    headers.delete('Content-Length')
    headers['X-Accel-Buffering'] = 'no'
    headers['Cache-Control'] = 'no-cache'
    headers['Content-Type'] = 'text/csv; charset=utf-8'
    headers['Content-Disposition'] = "attachment; filename=#{filename}"
  end
end 