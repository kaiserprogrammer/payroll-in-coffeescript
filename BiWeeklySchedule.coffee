class BiWeeklySchedule
  constructor: ->

  isPayDate: (date) ->
    weeks = Math.floor(date.getTime() / (1000*60*60*24*7)) + 1
    date.getDay() == 5 && (weeks % 2 == 0)

  getPayPeriodStartDate: (date) ->
    new Date(date.getFullYear(), date.getMonth(), date.getDate() - 13)

module.exports = BiWeeklySchedule