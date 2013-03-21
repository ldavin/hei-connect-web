(namespace "HEIConnect.Widgets").Calendar =
  class Calendar
    constructor: (@selector, @events) ->
      @height = null
      @minTime = 6
      @maxTime = 23

      return this

    render: ->
      $(@selector).fullCalendar
        header:
          left: "prev,next today"
          center: "title"
          right: ""

        allDaySlot: false
        axisFormat: "H'h'(mm)"
        columnFormat:
          week: "ddd dd/MM"
        dayNamesShort: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam']
        defaultView: 'agendaWeek'
        editable: false
        events: @events
        firstDay: 1
        firstHour: 8
        height: @height if @height isnt null
        maxTime: @maxTime
        minTime: @minTime
        monthNames: ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet',
                     'août', 'septembre', 'octobre', 'novembre', 'décembre']
        timeFormat: "H'h'mm{ - H'h'mm}"
        titleFormat:
          week: "d[ MMMM]{ '&#8212;' d MMMM yyyy}"