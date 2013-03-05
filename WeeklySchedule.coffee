class WeeklySchedule
  constructor: ->

  isPayDate: (date) ->
    date.getDay() == 5

  getPayPeriodStartDate: (date) ->
    new Date(date.getFullYear(), date.getMonth(), date.getDate() - 5)

module.exports = WeeklySchedule