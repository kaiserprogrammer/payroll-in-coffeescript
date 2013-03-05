p = require "./Package"

class AddSalesReceipt
  constructor: (@empId, @date, @amount, @db) ->

  execute: ->
    e = @db.getEmployee(@empId)
    pc = e.classification
    pc.addSalesReceipt(new p.SalesReceipt(@date, @amount))



module.exports = AddSalesReceipt