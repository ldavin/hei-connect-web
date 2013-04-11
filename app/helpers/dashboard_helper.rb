# encoding: utf-8

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
end
