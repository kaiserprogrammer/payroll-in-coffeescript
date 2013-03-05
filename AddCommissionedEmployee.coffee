p = require "./Package"
AddEmployee = require "./AddEmployee"

class AddCommissionedEmployee extends AddEmployee
  constructor: (name, address, @salary, @rate, db) ->
    super(name, address, db)

  make_classification: ->
    @e.classification = new p.CommissionedClassification(@salary, @rate)

  make_schedule: ->
    @e.schedule = new p.BiWeeklySchedule()

module.exports = AddCommissionedEmployee