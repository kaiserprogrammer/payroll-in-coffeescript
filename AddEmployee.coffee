p = require "./Package"

class AddEmployee
  constructor: (@name, @address, @db) ->

  execute: ->
    @e = new p.Employee(@name, @address)
    @make_classification()
    @make_schedule()
    @e.payment_method = new p.HoldMethod()
    @db.addEmployee(@e)
    @empId = @e.empId


module.exports = AddEmployee