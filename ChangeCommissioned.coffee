p = require "./Package"
ChangeEmployee = require "./ChangeEmployee"

class ChangeCommissioned extends ChangeEmployee
  constructor: (empId, @salary, @rate, db) ->
    super(empId, db)

  change: ->
    @e.classification = new p.CommissionedClassification(@salary, @rate)
    @e.schedule = new p.BiWeeklySchedule()

module.exports = ChangeCommissioned