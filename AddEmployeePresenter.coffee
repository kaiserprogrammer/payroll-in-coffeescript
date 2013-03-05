class AddEmployeePresenter
  constructor: (@view, @container, @db) ->
    @hourly = false
    @hasSalary = false
    @hasCommission = false
    @hourlyRate = 0
    @salary = 0
    @commission = 0
    @commissionSalary = 0
    @name = ""
    @address = ""

  updateView: ->
    @view.submitEnabled = @hasAllInformationCollected()

  hasAllInformationCollected: ->
    (!(@name.empty?) && !(@address.empty?)) &&
    (@hourly && @hourlyRate > 0) ||
    (@hasSalary && @salary > 0) ||
    (@hasCommission && @commission > 0 && @commissionSalary > 0)

module.exports = AddEmployeePresenter