json.extract! item, :id, :name, :typ, :presence, :only_integer, :format_with, :created_at, :updated_at
json.url item_url(item, format: :json)