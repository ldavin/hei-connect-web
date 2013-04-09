(namespace 'HEIConnect.Pages').dashboard =
  init: ->

  index: ->
    calendar = new HEIConnect.Widgets.Calendar '#full-calendar', HEIConnect.Data.events
    calendar.height = 300
    calendar.minTime = 8
    calendar.maxTime = 21
    calendar.render()

    average = new HEIConnect.Widgets.Average 'average-chart', HEIConnect.Data.grades, 'date', ['grade'], ['Moyenne']
    average.render()

  courses: ->
    calendar = new HEIConnect.Widgets.Calendar '#full-calendar', HEIConnect.Data.events
    calendar.render()
