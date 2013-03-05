class MemoryDB
  constructor: ->
    @employees = {}
    @members = {}
    @id = 0

  getEmployee: (id) ->
    @employees[id]

  getAllEmployees: ->
    for _,empl of @employees
      empl

  addEmployee: (employee) ->
    employee.empId = @nextid()
    @employees[employee.empId] = employee

  deleteEmployee: (empId) ->
    delete @employees[empId]

  getUnionMember: (id) ->
    @members[id]

  addUnionMember: (employee) ->
    employee.memberId = @nextid()
    @members[employee.memberId] = employee

  deleteUnionMember: (memberId) ->
    @members[memberId].memberId = undefined
    delete @members[memberId]

  nextid: ->
    ++@id

module.exports = MemoryDB