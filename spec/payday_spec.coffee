p = require "../Package"

validate_paycheck = (pt, empId, pay_date, pay, deductions) ->
  pc = pt.getPayCheck(empId)
  expect(pc).not.toBeUndefined()
  expect(pc.payDate).toEqual pay_date
  expect(pc.grossPay).toBe pay
  expect(pc.disposition).toEqual "Hold"
  expect(pc.deductions).toBe deductions
  expect(pc.netPay).toBe (pay - deductions)

validate_hourly_paycheck = (pt, empId, pay_date, pay, deductions) ->
  validate_paycheck(pt, empId, pay_date, pay, deductions)

validate_commissioned_paycheck = (pt, empId, pay_date, pay, deductions) ->
  validate_paycheck(pt, empId, pay_date, pay, deductions)

describe "Payday", ->
  it "should pay a single salaried employee", ->
    db = new p.MemoryDB()
    t = new p.AddSalariedEmployee("Bill", "Home", 1000.0, db)
    t.execute()

    pay_date = new Date(2001, 10, 30)
    pt = new p.Payday(pay_date, db)
    pt.execute()

    pc = pt.getPayCheck(t.empId)
    expect(pc.payDate).toEqual(pay_date)
    expect(pc.grossPay).toBe 1000.0
    expect(pc.disposition).toEqual "Hold"
    expect(pc.deductions).toBe 0
    expect(pc.netPay).toBe 1000.0

  it "should not pay a salaried employee on wrong date", ->
    db = new p.MemoryDB()
    t = new p.AddSalariedEmployee("Bob", "Home", 1100.0, db)
    t.execute()

    pay_date = new Date(2001, 10, 29)
    pt = new p.Payday(pay_date, db)
    pt.execute()
    pc = pt.getPayCheck(t.empId)
    expect(pc).toBeUndefined()

  it "should pay 0 to a single hourly employee with no time cards", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bob", "Home", 15.25, db)
    t.execute()

    pay_date = new Date(2001, 10, 9)
    pt = new p.Payday(pay_date, db)
    pt.execute()

    validate_hourly_paycheck(pt, t.empId, pay_date, 0, 0)

  it "should pay a single hourly employee with one timecard", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    pay_date = new Date(2001, 10, 9)
    tc = new p.AddTimeCard(t.empId, pay_date, 2.0, db)
    tc.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()

    validate_hourly_paycheck(pt, t.empId, pay_date, 30.5, 0)

  it "should pay for over time", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bob", "Home", 15.25, db)
    t.execute()

    pay_date = new Date(2001, 10, 9)
    tc = new p.AddTimeCard(t.empId, pay_date, 9.0, db)
    tc.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()
    validate_hourly_paycheck(pt, t.empId, pay_date, (8+1.5)*15.25, 0)

  it "should not pay hourly employee on wrong date", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    pay_date = new Date(2001, 10, 8)
    tc = new p.AddTimeCard(t.empId, pay_date, 9.0, db)
    tc.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()
    expect(pt.getPayCheck(t.empId)).toBeUndefined()

  it "should pay hourly employee two time cards", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    pay_date = new Date(2001, 10, 9)
    tc = new p.AddTimeCard(t.empId, pay_date, 5.0, db)
    tc.execute()
    tc2 = new p.AddTimeCard(t.empId, new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() - 1), 6.0, db)
    tc2.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()
    validate_hourly_paycheck(pt, t.empId, pay_date, 11*15.25, 0)

  it "should pay only one pay period", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bill", "Home", 15.25, db)
    t.execute()

    pay_date = new Date(2001, 10, 9)
    tc = new p.AddTimeCard(t.empId, pay_date, 5.0, db)
    tc.execute()
    tc2 = new p.AddTimeCard(t.empId, new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() - 7), 5.0, db)
    tc2.execute()
    tc3 = new p.AddTimeCard(t.empId, new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() + 7), 5.0, db)
    tc3.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()
    validate_hourly_paycheck(pt, t.empId, pay_date, 5*15.25, 0)

  it "should pay a commissioned employee with no commission", ->
    db = new p.MemoryDB()
    t = new p.AddCommissionedEmployee("Bob", "Home", 1000.0, 2.5, db)
    t.execute()

    pay_date = new Date(2001, 10, 16)
    pt = new p.Payday(pay_date, db)
    pt.execute()
    validate_commissioned_paycheck(pt, t.empId, pay_date, 1000.0, 0)

  it "should pay a commissioned employee with one commission only for current pay period", ->
    db = new p.MemoryDB()
    t = new p.AddCommissionedEmployee("Bob", "Home", 1000.0, 10.0, db)
    t.execute()

    pay_date = new Date(2001, 10, 16)
    in_pay_period_date = new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() - 1)
    early_date = new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() - 14)
    late_date = new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() + 1)
    new p.AddSalesReceipt(t.empId, in_pay_period_date, 500, db).execute()
    new p.AddSalesReceipt(t.empId, early_date, 500, db).execute()
    new p.AddSalesReceipt(t.empId, late_date, 500, db).execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()
    validate_commissioned_paycheck(pt, t.empId, pay_date, 1050.0, 0)

  it "should not pay a commissioned employee on wrong date", ->
    db = new p.MemoryDB()
    t = new p.AddCommissionedEmployee("Bob", "Home", 1000.0, 2.5, db)
    t.execute()

    pay_date = new Date(2001, 10, 23)
    pt = new p.Payday(pay_date, db)
    pt.execute()
    expect(pt.getPayCheck(t.empId)).toBeUndefined()

  it "should deduct service charges from member", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bob", "Home", 15.24, db)
    t.execute()

    cmt = new p.ChangeUnionMember(t.empId, 9.42, db)
    cmt.execute()

    e = db.getEmployee(t.empId)

    pay_date = new Date(2001, 10, 9)
    sct = new p.AddServiceCharge(e.memberId, pay_date, 19.42, db)
    sct.execute()

    tct = new p.AddTimeCard(e.empId, pay_date, 8.0, db)
    tct.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()

    validate_hourly_paycheck(pt, e.empId, pay_date, 8*15.24, 9.42+19.42)

  it "should deduct service charges correct when spannig multiple pay periods", ->
    db = new p.MemoryDB()
    t = new p.AddHourlyEmployee("Bob", "Home", 15.25, db)
    t.execute()

    cmt = new p.ChangeUnionMember(t.empId, 9.42, db)
    cmt.execute()

    e = db.getEmployee(t.empId)

    pay_date = new Date(2001, 10, 9)
    early_date = new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() - 7)
    late_date = new Date(pay_date.getFullYear(), pay_date.getMonth(), pay_date.getDate() + 1)
    sct = new p.AddServiceCharge(e.memberId, pay_date, 19.42, db)
    sct.execute()
    sct_early = new p.AddServiceCharge(e.memberId, early_date, 100.0, db)
    sct_early.execute()
    sct_late = new p.AddServiceCharge(e.memberId, late_date, 100.0, db)
    sct_late.execute()

    tct = new p.AddTimeCard(e.empId, pay_date, 8.0, db)
    tct.execute()

    pt = new p.Payday(pay_date, db)
    pt.execute()

    validate_hourly_paycheck(pt, e.empId, pay_date, 8*15.25, 9.42+19.42)