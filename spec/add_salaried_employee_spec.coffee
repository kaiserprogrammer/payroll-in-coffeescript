p = require "../Package"

describe "AddSalariedEmployee", ->
  it "should create an hourly employee", ->
    db = new p.MemoryDB
    t = new p.AddSalariedEmployee("Bob", "Home", 1100.0, db)
    t.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()
    expect(e.name).toBe "Bob"
    expect(e.address).toBe "Home"

    pc = e.classification
    expect(pc.constructor).toBe p.SalariedClassification
    expect(pc.salary).toBe 1100.0

    ps = e.schedule
    expect(ps.constructor).toBe p.MonthlySchedule

    pm = e.payment_method
    expect(pm.constructor).toBe p.HoldMethod
