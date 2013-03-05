p = require "./Package"

class AddServiceCharge
  constructor: (@memberId, @date, @amount, @db) ->

  execute: ->
    e = @db.getUnionMember(@memberId)
    charge = new p.ServiceCharge(@date, @amount)
    e.affiliation.addServiceCharge(charge)

module.exports = AddServiceCharge