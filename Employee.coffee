p = require "./Package"

class Employee
  constructor: (@name, @address) ->
    @affiliation = p.NoAffiliation

  isPayDate: (date) ->
    @schedule.isPayDate(date)

  getPayPeriodStartDate: (date) ->
    @schedule.getPayPeriodStartDate(date)

  payday: (pc) ->
    @classification.calculatePay(pc)
    @affiliation.calculateDeductions(pc)
    @payment_method.pay(pc)

module.exports = Employee