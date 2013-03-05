p = require "../Package"

describe "ChangeUnaffiliated", ->
  it "should change an employee with a union affiliation to one with none", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 1500, db)
    t.execute()

    cut = new p.ChangeUnionMember(t.empId, 99.42, db)
    cut.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()

    cuat = new p.ChangeUnaffiliated(t.empId, db)
    cuat.execute()

    af = e.affiliation
    expect(af).toBe p.NoAffiliation

    member = db.getUnionMember(e.memberId)
    expect(member).toBeUndefined()