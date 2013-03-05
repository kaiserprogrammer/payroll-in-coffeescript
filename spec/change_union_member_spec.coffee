p = require "../Package"

describe "ChangeUnionMember", ->
  it "should change an employee to have a union affiliation", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 1500, db)
    t.execute()

    cut = new p.ChangeUnionMember(t.empId, 99.42, db)
    cut.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()

    af = e.affiliation
    expect(af.dues).toBe 99.42

    member = db.getUnionMember(e.memberId)
    expect(member).not.toBeUndefined()
    expect(member).toBe e