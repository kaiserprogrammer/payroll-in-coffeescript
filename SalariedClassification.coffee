class SalariedClassification
  constructor: (@salary) ->

  calculatePay: (pc) ->
    pc.grossPay = @salary

module.exports = SalariedClassification