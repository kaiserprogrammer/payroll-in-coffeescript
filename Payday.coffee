p = require "./Package"

class Payday
  constructor: (@payDate, @db) ->
    @paychecks = {}

  execute: ->
    employees = @db.getAllEmployees()
    for employee in employees
      if employee.isPayDate(@payDate)
        start_date = employee.getPayPeriodStartDate(@payDate)
        pc = new p.Paycheck(start_date, @payDate)
        employee.payday(pc)
        @paychecks[employee.empId] = pc

  getPayCheck: (empId) ->
    @paychecks[empId]

module.exports = Payday