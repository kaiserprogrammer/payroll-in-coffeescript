p = require("./Package")
AddEmployee = require "./AddEmployee"

class AddHourlyEmployee extends AddEmployee
  constructor: (name, address, @rate, db) ->
    super(name, address, db)

  make_classification: ->
    @e.classification = new p.HourlyClassification(@rate)

  make_schedule: ->
    @e.schedule = new p.WeeklySchedule

module.exports = AddHourlyEmployee