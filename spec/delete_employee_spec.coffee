p = require "../Package"

describe "DeleteEmployee", ->
  it "should delete a previously created Employee", ->
    db = new p.MemoryDB()
    t = new p.AddCommissionedEmployee("Bill", "Home", 2500, 3.2, db)
    t.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()

    dt = new p.DeleteEmployee(t.empId, db)
    dt.execute()

    e = db.getEmployee(t.empId)
    expect(e).toBeUndefined()