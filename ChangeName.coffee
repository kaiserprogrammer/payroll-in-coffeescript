ChangeEmployee = require "./ChangeEmployee"

class ChangeName extends ChangeEmployee
  constructor: (empId, @name, db) ->
    super(empId, db)

  change: ->
    @e.name = @name

module.exports = ChangeName