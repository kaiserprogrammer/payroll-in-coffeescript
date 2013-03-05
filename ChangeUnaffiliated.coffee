ChangeEmployee = require "./ChangeEmployee"
p = require "./Package"

class ChangeUnaffiliated extends ChangeEmployee
  constructor: (empId, db) ->
    super(empId, db)

  change: ->
    @db.deleteUnionMember(@e.memberId)
    @e.affiliation = p.NoAffiliation

module.exports = ChangeUnaffiliated