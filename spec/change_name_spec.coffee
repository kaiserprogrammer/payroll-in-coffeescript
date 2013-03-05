p = require "../Package"

describe "ChangeName", ->
  it "should change an employees name", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Work", 20.0, db)
    t.execute()

    cnt = new p.ChangeName(t.empId, "Bob", db)
    cnt.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined
    expect(e.name).toBe "Bob"