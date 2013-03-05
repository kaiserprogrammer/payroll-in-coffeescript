p = require "../Package"

describe "ChangeSalaried", ->
  it "should change an employees payment classification to salaried", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    cst = new p.ChangeSalaried(t.empId, 1500.0, db)
    cst.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined

    pc = e.classification
    expect(pc.constructor).toBe p.SalariedClassification
    expect(pc.salary).toBe 1500

    ps = e.schedule
    expect(ps.constructor).toBe p.MonthlySchedule