json.array!(@pins) do |pin|
  json.extract! pin, :id, :title, :description, :board_id, :link
  json.url pin_url(pin, format: :json)
end
