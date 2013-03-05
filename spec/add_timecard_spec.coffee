p = require "../Package"

describe "AddTimeCard", ->
  it "should add a timecard to an employee", ->
    db = new p.MemoryDB
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    tct = new p.AddTimeCard(t.empId, new Date(2005, 7, 31), 8.0, db)
    tct.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()
    pc = e.classification
    expect(pc.constructor).toBe p.HourlyClassification

    tc = pc.getTimeCard(new Date(2005, 7, 31))
    expect(tc.hours).toBe 8.0
    expect(tc.date).toEqual new Date(2005, 7, 31)
