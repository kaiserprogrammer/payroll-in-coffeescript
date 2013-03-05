class NoAffiliation
  calculateDeductions: (pc) ->
    pc.deductions = 0

module.exports = new NoAffiliation()