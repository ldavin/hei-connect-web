json.courses @courses do |course|
    json.id course.id
    json.kind course.kind
    json.name course.short_name
    json.place course.place
    json.date course.date
    json.end_date course.end_date
end

json.last_update do
    json.state @update.state
    json.updated_at @update.updated_at
end