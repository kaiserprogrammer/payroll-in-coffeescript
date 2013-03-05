ChangeEmployee = require "./ChangeEmployee"
p = require "./Package"

class ChangeUnionMember extends ChangeEmployee
  constructor: (empId, @dues, db) ->
    super(empId, db)

  change: ->
    @db.addUnionMember(@e)
    @e.affiliation = new p.UnionAffiliation(@dues)

module.exports = ChangeUnionMember