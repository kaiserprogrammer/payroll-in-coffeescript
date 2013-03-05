class HoldMethod
  pay: (pc) ->
    pc.disposition = "Hold"
    pc.netPay = pc.grossPay - pc.deductions

module.exports = HoldMethod