ChangeEmployee = require "./ChangeEmployee"

class ChangeAddress extends ChangeEmployee
  constructor: (empId, @address, db) ->
    super(empId, db)

  change: ->
    @e.address = @address

module.exports = ChangeAddress