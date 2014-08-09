json.absences @absences do |absence|
  json.id absence.id
  json.section_name absence.section.name
  json.date absence.date
  json.length absence.length
end

json.last_update do
  json.state @update.state
  json.updated_at @update.updated_at
end