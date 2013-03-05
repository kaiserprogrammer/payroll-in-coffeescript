p = require "./Package"
ChangeEmployee = require "./ChangeEmployee"

class ChangeSalaried extends ChangeEmployee
  constructor: (empId, @salary, db) ->
    super(empId, db)

  change: ->
    @e.classification = new p.SalariedClassification(@salary)
    @e.schedule = new p.MonthlySchedule()

module.exports = ChangeSalaried