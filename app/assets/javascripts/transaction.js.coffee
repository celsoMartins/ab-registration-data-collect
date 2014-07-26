# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  reports = $(".report")
  categories = reports.map ->
    $(this).find('.date').text()
  initiated = reports.map ->
    parseInt($(this).find('.initiated').text(), 10)
  open = reports.map ->
    parseInt($(this).find('.open').text(), 10)
  available = reports.map ->
    parseInt($(this).find('.available').text(), 10)
  in_analysis = reports.map ->
    parseInt($(this).find('.in_analysis').text(), 10)
  paid = reports.map ->
    parseInt($(this).find('.paid').text(), 10)
  in_dispute = reports.map ->
    parseInt($(this).find('.in_dispute').text(), 10)
  refunded = reports.map ->
    parseInt($(this).find('.refunded').text(), 10)
  cancelled = reports.map ->
    parseInt($(this).find('.cancelled').text(), 10)

  $("#graph_container").highcharts
    chart:
      type: "area"

    title:
      text: "Inscritos ao longo do tempo"

    xAxis:
      categories: categories
      tickmarkPlacement: "on"
      title:
        enabled: false

    yAxis:
      title:
        text: "# de inscritos"

      labels:
        formatter: ->
          @value

    tooltip:
      shared: true

    stacking: "normal"

    plotOptions:
      area:
        stacking: "normal"
        lineColor: "#666666"
        lineWidth: 1
        marker:
          lineWidth: 1
          lineColor: "#666666"

    series: [
      {
        name: "Iniciadas"
        data: initiated
      }
      {
        name: "Abertas"
        data: open
        color: "#7cb5ec"
      }
      {
        name: "Disponíveis"
        data: available
        color: "#ceed91"
      }
      {
        name: "Em Análise"
        data: in_analysis
        color: '#89ff94'
      }
      {
        name: "Pagas"
        data: paid
        color: "#80e16d"
      }
      {
        name: "Em Disputa"
        data: in_dispute
        color: "#ff9900"
      }
      {
        name: "Reembolsadas"
        data: refunded
        color: "#ff835c"
      }
      {
        name: "Canceladas"
        data: cancelled
        color: "#434348"
      }
    ]
