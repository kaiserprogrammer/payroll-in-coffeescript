class DeleteEmployee
  constructor: (@empId, @db) ->

  execute: ->
    @db.deleteEmployee(@empId)

module.exports = DeleteEmployee