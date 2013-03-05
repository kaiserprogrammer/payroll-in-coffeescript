p = require "../Package"

class MockAddEmployeeView
  constructor: ->
    @submitEnabled = false

class TransactionContainer

describe "AddEmployeePresenter", ->

  beforeEach ->
    @view = new MockAddEmployeeView()
    @container = new TransactionContainer()
    @db = new p.MemoryDB()
    @presenter = new p.AddEmployeePresenter(@view, @container, @db)

  it "should have all infos collected", ->
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.name = "Bill"
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.address = "123 abc"
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.hourly = true
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.hourlyRate = 1.23
    expect(@presenter.hasAllInformationCollected()).toBe true


    @presenter.hourly = false
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.hasSalary = true
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.salary = 1234
    expect(@presenter.hasAllInformationCollected()).toBe true

    @presenter.hasSalary = false
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.hasCommission = true
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.commissionSalary = 1234
    expect(@presenter.hasAllInformationCollected()).toBe false
    @presenter.commission = 12
    expect(@presenter.hasAllInformationCollected()).toBe true

  it "should udpate view", ->
    @presenter.name = "Bill"
    expect(@view.submitEnabled).toBe false

    @presenter.address = "123 abc"
    expect(@view.submitEnabled).toBe false

    @presenter.hourly = true
    expect(@view.submitEnabled).toBe false

    @presenter.hourlyRate = 1.23
    @presenter.updateView()
    expect(@view.submitEnabled).toBe true
