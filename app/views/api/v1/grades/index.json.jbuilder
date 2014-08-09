json.grades @grades do |grade|
  json.id grade.id
  json.section_name grade.exam.section.name
  json.exam_name grade.exam.name
  json.date grade.exam.date
  json.unknown grade.unknown
  json.mark grade.mark
  json.average grade.exam.average
  json.average_count grade.exam.grades_count
end

json.last_update do
  json.state @update.state
  json.updated_at @update.updated_at
end