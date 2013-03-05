p = require "../Package"

describe "AddSalesReceipt", ->
  it "should add a sales receipt to an employee", ->
    db = new p.MemoryDB
    t = new p.AddCommissionedEmployee("John", "Home", 1500.0, 2.5, db)
    t.execute()

    srt = new p.AddSalesReceipt(t.empId, new Date(2005, 3, 30), 500, db)
    srt.execute()

    e = db.getEmployee(t.empId)
    expect(e).not.toBeUndefined()

    pc = e.classification
    expect(pc.constructor).toBe p.CommissionedClassification

    srs = pc.getSalesReceipts()
    expect(srs[0].amount).toBe 500
    expect(srs[0].date).toEqual new Date(2005, 3, 30)
