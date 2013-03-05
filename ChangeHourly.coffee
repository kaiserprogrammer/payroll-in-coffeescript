p = require "./Package"
ChangeEmployee = require "./ChangeEmployee"

class ChangeHourly extends ChangeEmployee
  constructor: (empId, @rate, db) ->
    super(empId, db)

  change: ->
    @e.classification = new p.HourlyClassification(@rate)
    @e.schedule = new p.WeeklySchedule()

module.exports = ChangeHourly