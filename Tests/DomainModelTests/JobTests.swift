import XCTest
@testable import DomainModel

class JobTests: XCTestCase {
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        XCTAssert(job.calculateIncome(100) == 1000)
        // Salary jobs pay the same no matter how many hours you work
    }
    
    //EC test # 16 Check for negative hourly salary
    func testNegHourlySalary() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Hourly(-10.0))
        XCTAssert(job.calculateIncome(50) == 0)
        XCTAssert(job.calculateIncome(100) == 0)
        // Salary jobs pay the same no matter how many hours you work
    }
    
    //EC test # 17 Check for 0 hourly salary
    func test0Salary() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Hourly(0.0))
        XCTAssert(job.calculateIncome(50) == 0)
        XCTAssert(job.calculateIncome(100) == 0)
        // Salary jobs pay the same no matter how many hours you work
    }

    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        XCTAssert(job.calculateIncome(20) == 300)
    }
    
    // EC Test #10 for convert hourly to salary
    func testConvert() {
        var job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        job = job.convert()
        XCTAssert(job.calculateIncome(50) == 30000)
    }
    
    // EC Test #11 for convert salary to hourly
    func testConvert2() {
        var job = Job(title: "Janitor", type: Job.JobType.Salary(30000))
        job = job.convert()
        XCTAssert(job.calculateIncome(2000) == 30000)
    }

    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)

        job.raise(byAmount: 1000)
        XCTAssert(job.calculateIncome(50) == 2000)

        job.raise(byPercent: 0.1)
        print(job.calculateIncome(50))
        XCTAssert(job.calculateIncome(50) == 2200)
    }

    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)

        job.raise(byAmount: 1.0)
        XCTAssert(job.calculateIncome(10) == 160)

        job.raise(byPercent: 1.0) // Nice raise, bruh
        XCTAssert(job.calculateIncome(10) == 320)
    }
  
    static var allTests = [
        ("testCreateSalaryJob", testCreateSalaryJob),
        ("testCreateHourlyJob", testCreateHourlyJob),
        ("testSalariedRaise", testSalariedRaise),
        ("testHourlyRaise", testHourlyRaise),
        
        ("testNegHourlySalary", testNegHourlySalary),
        ("test0Salary", test0Salary),
    ]
}
