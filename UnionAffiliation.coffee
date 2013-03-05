class UnionAffiliation
  constructor: (@dues) ->
    @charges = {}

  getServiceCharge: (date) ->
    @charges[date]

  addServiceCharge: (charge) ->
    @charges[charge.date] = charge

  calculateDeductions: (paycheck) ->
    sum = @dues
    for _, charge of @charges
      if paycheck.startDate <= charge.date <= paycheck.payDate
        sum += charge.amount
    paycheck.deductions = sum

module.exports = UnionAffiliation