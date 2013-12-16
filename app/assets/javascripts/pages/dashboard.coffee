(namespace 'HEIConnect.Pages').dashboard =
  init: ->
    $('#status_table .label').popover() if $('#status_table .label').length

  index: ->
    if $('#calendar_data').length
      calendar = new HEIConnect.Widgets.Calendar '#full-calendar', $('#calendar_data').data('events')
      calendar.height = 300
      calendar.minTime = 8
      calendar.maxTime = 21
      calendar.render()

    if $('#average_data').length
      average = new HEIConnect.Widgets.Average 'average-chart', $('#average_data').data('grades'),
                                               $('#average_data').data('x'),
                                               $('#average_data').data('y'),
                                               $('#average_data').data('labels'),
                                               $('#average_data').data('goals')
      average.render()

    if $('#absences_data').length
      absences = new HEIConnect.Widgets.Absence 'absences-chart', $('#absences_data').data('absences'),
        $('#absences_data').data('x'),
        $('#absences_data').data('y'),
        $('#absences_data').data('labels'),
        $('#absences_data').data('colors')
      absences.render()

  courses: ->
    if $('#calendar_data').length
      calendar = new HEIConnect.Widgets.Calendar '#full-calendar', $('#calendar_data').data('events')
      calendar.render()


  grades: ->
    if $('#average_data').length
      average = new HEIConnect.Widgets.Average 'average-chart', $('#average_data').data('grades'),
                                               $('#average_data').data('x'),
                                               $('#average_data').data('y'),
                                               $('#average_data').data('labels'),
                                               $('#average_data').data('goals')
      average.render()

  absences: ->
    if $('#absences_data').length
      absences = new HEIConnect.Widgets.Absence 'absences-chart', $('#absences_data').data('absences'),
                                               $('#absences_data').data('x'),
                                               $('#absences_data').data('y'),
                                               $('#absences_data').data('labels'),
                                               $('#absences_data').data('colors')
      absences.render()