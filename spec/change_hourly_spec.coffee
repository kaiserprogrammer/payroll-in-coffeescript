p = require "../Package"

describe "ChangeHourly", ->
  it "should change an employees classification to hourly", ->
    db = new p.MemoryDB()
    t = new p.AddCommissionedEmployee("Bill", "Home", 1000, 3.0, db)
    t.execute()

    cht = new p.ChangeHourly(t.empId, 15.25, db)
    cht.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined

    pc = e.classification
    expect(pc.constructor).toBe p.HourlyClassification
    expect(pc.rate).toBe 15.25

    ps = e.schedule
    expect(ps.constructor).toBe p.WeeklySchedule