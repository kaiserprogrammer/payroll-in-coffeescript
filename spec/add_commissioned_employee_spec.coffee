p = require "../Package"

describe "AddCommissionedEmployee", ->
  it "should create an hourly employee", ->
    db = new p.MemoryDB
    t = new p.AddCommissionedEmployee("Jim", "Garden", 500.0, 100.0, db)
    t.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()
    expect(e.name).toBe "Jim"
    expect(e.address).toBe "Garden"

    pc = e.classification
    expect(pc.constructor).toBe p.CommissionedClassification
    expect(pc.salary).toBe 500.0
    expect(pc.rate).toBe 100.0

    ps = e.schedule
    expect(ps.constructor).toBe p.BiWeeklySchedule

    pm = e.payment_method
    expect(pm.constructor).toBe p.HoldMethod
