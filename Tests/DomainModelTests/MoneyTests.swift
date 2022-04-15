import XCTest
@testable import DomainModel

class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
    let tenYuan = Money(amount: 10, currency: "Yuan")
    let negEUR = Money(amount: -15, currency: "EUR")

  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")

    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }

  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }

  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }

  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
  }

  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
  }
    
    // EC test #1 test convert illegal currency: print out currency that is not in the bank,
    // and return self, which is 10 USD in this case
    func testUSDtoYuan() {
      let yuan = tenUSD.convert("Yuan")
      XCTAssert(yuan.currency == "USD")
      XCTAssert(yuan.amount == 10)
    }
    
    // EC test #2 test add illegal currency: print out currency that is not in the bank,
    // and return self, which is 10 USD in this case
    func testAddUSDtoYuan() {
      let total = tenUSD.add(tenYuan)
      XCTAssert(total.amount == 10)
      XCTAssert(total.currency == "USD")
    }
    
    // EC test # 3 test convert negative amount: Print out amount is illegal
    // and then return self which is EUR -10 in this case
    func testConvertNeg() {
      let usd = negEUR.convert("USD")
      XCTAssert(usd.currency == "EUR")
      XCTAssert(usd.amount == -15)
    }
    
    // EC test # 4 test add negative amount: Print out amount is illegal
    // and then return self which is 10 USD in this case
    func testAddNeg() {
      let total = tenUSD.add(negEUR)
      XCTAssert(total.amount == 10)
      XCTAssert(total.currency == "USD")
    }

    // EC test # 5 test negative add positive: Print out amount is illegal
    // and then return self which is -10 EUR in this case
    func testNegAdd() {
      let total = negEUR.add(tenUSD)
      XCTAssert(total.amount == -15)
      XCTAssert(total.currency == "EUR")
    }
    
    // EC test # 6 test multiple convert while one of them is illegal currency
    func testUSDtoYuantoUSD() {
      let eur = tenUSD.convert("Yuan")
      let usd = eur.convert("USD")
      XCTAssert(tenUSD.amount == usd.amount)
      XCTAssert(tenUSD.currency == usd.currency)
    }
    
    static var allTests = [
        ("testCanICreateMoney", testCanICreateMoney),

        ("testUSDtoGBP", testUSDtoGBP),
        ("testUSDtoEUR", testUSDtoEUR),
        ("testUSDtoCAN", testUSDtoCAN),
        ("testGBPtoUSD", testGBPtoUSD),
        ("testEURtoUSD", testEURtoUSD),
        ("testCANtoUSD", testCANtoUSD),
        ("testUSDtoEURtoUSD", testUSDtoEURtoUSD),
        ("testUSDtoGBPtoUSD", testUSDtoGBPtoUSD),
        ("testUSDtoCANtoUSD", testUSDtoCANtoUSD),

        ("testAddUSDtoUSD", testAddUSDtoUSD),
        ("testAddUSDtoGBP", testAddUSDtoGBP),
        
        ("testUSDtoYuan", testUSDtoYuan),
        ("testAddUSDtoYuan", testAddUSDtoYuan),
        ("testConvertNeg", testConvertNeg),
        ("testAddNeg", testAddNeg),
        ("testNegAdd", testNegAdd)
    ]
}

