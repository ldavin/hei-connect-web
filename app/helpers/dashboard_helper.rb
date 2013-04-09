module DashboardHelper
  def grades_to_chart_data(grades)
    # Sort grades and declare counters
    grades = grades.sort { |x, y| x.date <=> y.date }
    points = 0
    coefficients = 0
    final_array = Array.new

    # Only keep known grades
    grades.keep_if { |g| not g.unknown }

    # Group grades by date
    grades = grades.group_by { |g| g.date }

    # Compute array
    grades.each do |date, gs|
      gs.each do |g|
        points += g.mark * g.weight
        coefficients += g.weight
      end

      final_array.push({date: date, grade: (points / coefficients).round(3)})
    end

    final_array
  end
end
