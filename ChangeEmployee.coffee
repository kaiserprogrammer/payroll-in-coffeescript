class ChangeEmployee
  constructor: (@empId, @db) ->

  execute: ->
    @e = @db.getEmployee(@empId)
    @change()

module.exports = ChangeEmployee