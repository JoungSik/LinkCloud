json.extract! link, :id, :name, :url, :created_at, :updated_at
json.tag_list link.tag_list.join(', ')