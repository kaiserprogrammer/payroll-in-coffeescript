class CommissionedClassification
  constructor: (@salary, @rate) ->
    @sales_receipts = []

  getSalesReceipts: ->
    @sales_receipts

  addSalesReceipt: (sale) ->
    @sales_receipts.push(sale)

  calculatePay: (paycheck) ->
    sum = @salary
    for sale in @sales_receipts
      if paycheck.startDate <= sale.date <= paycheck.payDate
        sum += sale.amount * @rate / 100
    paycheck.grossPay = sum

module.exports = CommissionedClassification