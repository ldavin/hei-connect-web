(namespace 'HEIConnect.Pages').dashboard =
  init: ->

  index: ->
    calendar = new HEIConnect.Widgets.Calendar '#full-calendar', $('#calendar_data').data('events')
    calendar.height = 300
    calendar.minTime = 8
    calendar.maxTime = 21
    calendar.render()

    average = new HEIConnect.Widgets.Average 'average-chart', $('#average_data').data('grades'), 'date', ['grade'], ['Moyenne']
    average.render()
    $('#status_table .label').popover()

  courses: ->
    calendar = new HEIConnect.Widgets.Calendar '#full-calendar', $('#calendar_data').data('events')
    calendar.render()
