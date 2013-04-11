(namespace 'HEIConnect.Pages').dashboard =
  init: ->

  index: ->
    if $('#calendar_data').length
      calendar = new HEIConnect.Widgets.Calendar '#full-calendar', $('#calendar_data').data('events')
      calendar.height = 300
      calendar.minTime = 8
      calendar.maxTime = 21
      calendar.render()

    if $('#average_data').length
      average = new HEIConnect.Widgets.Average 'average-chart', $('#average_data').data('grades'), 'date', ['grade'],
                                               ['Moyenne']
      average.render()


    $('#status_table .label').popover() if $('#status_table .label').length

  courses: ->
    if $('#calendar_data').length
      calendar = new HEIConnect.Widgets.Calendar '#full-calendar', $('#calendar_data').data('events')
      calendar.render()
