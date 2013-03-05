p = require "../Package"

describe "AddHourlyEmployee", ->
  it "should create an hourly employee", ->
    db = new p.MemoryDB
    t = new p.AddHourlyEmployee("John", "Work", 20.0, db)
    t.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()
    expect(e.name).toBe "John"
    expect(e.address).toBe "Work"

    pc = e.classification
    expect(pc.constructor).toBe p.HourlyClassification
    expect(pc.rate).toBe 20.0

    ps = e.schedule
    expect(ps.constructor).toBe p.WeeklySchedule

    pm = e.payment_method
    expect(pm.constructor).toBe p.HoldMethod
