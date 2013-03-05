class HourlyClassification
  constructor: (@rate) ->
    @timecards = {}

  getTimeCard: (date) ->
    @timecards[date]

  addTimeCard: (timecard) ->
    @timecards[timecard.date] = timecard

  calculatePay: (paycheck) ->
    sum = 0
    for _, tc of @timecards
      if paycheck.startDate <= tc.date <= paycheck.payDate
        sum += @rate * tc.hours
        if tc.hours > 8
          sum += @rate * (tc.hours - 8) / 2
    paycheck.grossPay = sum



module.exports = HourlyClassification