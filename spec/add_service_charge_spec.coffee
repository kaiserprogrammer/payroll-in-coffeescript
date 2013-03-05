p = require "../Package"

describe "AddServiceCharge", ->
  it "should create a service charge for an employee", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    new p.ChangeUnionMember(t.empId, 10.0, db).execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()

    sct = new p.AddServiceCharge(e.memberId, new Date(2005, 8, 8), 12.95, db)
    sct.execute()

    sc = e.affiliation.getServiceCharge(new Date(2005, 8, 8))
    expect(sc).not.toBeUndefined()
    expect(sc.amount).toBe 12.95
    expect(sc.date).toEqual(new Date(2005, 8, 8))