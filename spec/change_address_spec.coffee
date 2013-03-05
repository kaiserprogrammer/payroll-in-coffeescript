p = require "../Package"

describe "ChangeAddress", ->
  it "should change an employees address", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Work", 20.0, db)
    t.execute()

    cat = new p.ChangeAddress(t.empId, "Home", db)
    cat.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined
    expect(e.address).toBe "Home"