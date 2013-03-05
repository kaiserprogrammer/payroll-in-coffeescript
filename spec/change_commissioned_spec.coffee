p = require "../Package"

describe "ChangeCommissioned", ->
  it "should change an employees payment classification to commissioned", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bob", "Home", 15.25, db)
    t.execute()
    cct = new p.ChangeCommissioned(t.empId, 1000, 3.0, db)
    cct.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined

    pc = e.classification
    expect(pc.constructor).toBe p.CommissionedClassification

    expect(pc.salary).toBe 1000.0
    expect(pc.rate).toBe 3.0

    ps = e.schedule
    expect(ps.constructor).toBe p.BiWeeklySchedule
