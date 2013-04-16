# encoding: utf-8

module DashboardHelper
  def grades_to_chart_data(grades)
    # Sort grades and declare counters
    grades = grades.sort { |x, y| x.exam.date <=> y.exam.date }
    points = 0
    average_points = 0
    coefficients = 0
    average_coefficients = 0
    array = Array.new

    # Only keep known grades
    grades.keep_if { |g| (not g.unknown) or (g.unknown and g.exam.grades_count > 0) }

    # Group grades by date
    grades = grades.group_by { |g| g.exam.date }

    # Compute array
    grades.each do |date, gs|
      gs.each do |g|
        unless g.unknown
          points += g.mark * g.exam.weight
          coefficients += g.exam.weight
        end

        average_points += g.exam.average * g.exam.weight
        average_coefficients += g.exam.weight
      end

      array.push({date: date, grade: (points / coefficients).round(3),
                  average: (average_points / average_coefficients).round(3)})
    end

    array
  end

  def update_status_label(update)
    case update.state
      when Update::STATE_UNKNOWN
        klass = ''
        text = 'Inconnu'
        tooltip = 'L\'application n\'a pas encore essayé de récupérer les données sur e-campus.'
      when Update::STATE_SCHEDULED
        klass = 'label-blue'
        text = 'Programmé'
        tooltip = 'Une demande de mise a jour a été ajoutée à la queue. L\'attente peut varier de quelques minutes à plus d\'une heure.'
      when Update::STATE_UPDATING
        klass = 'label-red'
        text = 'Mise à jour'
        tooltip = 'Une mise à jour est en cours, et sera terminée d\'ici quelques secondes.'
      when Update::STATE_OK
        klass = 'label-green'
        text = 'Ok'
        tooltip = 'La dernière mise à jour s\'est déroulé avec succès.'
      when Update::STATE_FAILED
        klass = 'label-orange'
        text = 'Echec'
        tooltip = 'La dernière mise à jour a échoué. Si vous remarquez que certaines mises à jour échouent trop souvent, contactez l\'équipe.'
      else
        klass = ''
        text = ''
        tooltip = ''
    end

    content_tag :a, text, rel: 'popover', class: ['label', klass].join(' '), data: {placement: 'top', content: tooltip, 'original-title' => 'Etat: ' + text}
  end

  def absence_type_label(absence)
    case absence.type
      when Absence::TYPE_EXCUSED
        klass = 'label-green'
      when Absence::TYPE_JUSTIFIED
        klass = 'label-blue'
      when Absence::TYPE_NOTHING
        klass = 'label-red'
    end

    content_tag :span, type, class: ['label', klass].join(' ')
  end
end
