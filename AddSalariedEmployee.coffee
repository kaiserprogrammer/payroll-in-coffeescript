AddEmployee = require "./AddEmployee"
p = require "./Package"

class AddSalariedEmployee extends AddEmployee
  constructor: (name, address, @salary, db) ->
    super(name, address, db)

  make_classification: ->
    @e.classification = new p.SalariedClassification(@salary)

  make_schedule: ->
    @e.schedule = new p.MonthlySchedule()

module.exports = AddSalariedEmployee
