(namespace "HEIConnect.Widgets").Average =
  class Average
    constructor: (@element_id, @data, @x_key, @y_keys, @labels, @goals) ->
      return this

    render: ->
      new Morris.Line(

        element: @element_id
        data: @data

        xkey: @x_key
        ykeys: @y_keys
        labels: @labels

        ymin: 'auto'
        ymax: 'auto'

        dateFormat: (x) ->
          d = new Date(x)
          curr_date = d.getDate()
          curr_month = d.getMonth() + 1
          curr_year = d.getFullYear()
          "#{curr_date}/#{curr_month}/#{curr_year}"

        goals: @goals
      )