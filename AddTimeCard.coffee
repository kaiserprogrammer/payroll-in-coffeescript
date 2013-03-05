p = require "./Package"

class AddTimeCard
  constructor: (@empId, @date, @hours, @db) ->

  execute: ->
    e = @db.getEmployee(@empId)

    pc = e.classification
    pc.addTimeCard(new p.TimeCard(@date, @hours))


module.exports = AddTimeCard