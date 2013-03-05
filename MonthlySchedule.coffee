class MonthlySchedule
  isPayDate: (date) ->
    next_date = new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1)
    (not (date.getMonth() == next_date.getMonth()))


  getPayPeriodStartDate: (date) ->
    new Date(
      date.getFullYear(),
      date.getMonth() - 1,
      date.getDate() + 2)


module.exports = MonthlySchedule