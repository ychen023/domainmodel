import XCTest
@testable import DomainModel

class PersonTests: XCTestCase {

    func testPerson() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
    
    //EC #12 testNoLastName
    func testNoLN() {
        let Bono = Person(firstName: "Bono", lastName: "", age: 45)
        XCTAssert(Bono.toString() == "[Person: firstName:Bono lastName: age:45 job:nil spouse:nil]")
    }
    
    //EC #13 testNoFirstName
    func testNoFN() {
        let Beyoncé = Person(firstName: "", lastName: "Beyoncé", age: 45)
        XCTAssert(Beyoncé.toString() == "[Person: firstName: lastName:Beyoncé age:45 job:nil spouse:nil]")
    }

    func testAgeRestrictions() {
        let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)

        matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(matt.job == nil)

        matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(matt.spouse == nil)
    }
    
    // EC #14 test other function with no First name
    func testFunctionNoFN() {
        let Beyoncé = Person(firstName: "", lastName: "Beyoncé", age: 15)

        Beyoncé.job = Job(title: "Singer", type: Job.JobType.Hourly(5.5))
        XCTAssert(Beyoncé.job == nil)

        Beyoncé.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 15)
        XCTAssert(Beyoncé.spouse == nil)
    }
    
    // EC #15 test other function with no Last name
    func testFunctionNoLN() {
        let Bono = Person(firstName: "Bono", lastName: "", age: 45)

        Bono.job = Job(title: "Singer", type: Job.JobType.Hourly(5.5))
        XCTAssert(Bono.job != nil)

        Bono.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(Bono.spouse != nil)
    }

    func testAdultAgeRestrictions() {
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)

        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(mike.job != nil)

        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(mike.spouse != nil)
    }
    
    // EC test # 7 Test edge case of age 16
    func testAdultAgeEdgeCase() {
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 16)

        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(mike.job != nil)

        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 16)
        XCTAssert(mike.spouse != nil)
    }

    static var allTests = [
        ("testPerson", testPerson),
        ("testAgeRestrictions", testAgeRestrictions),
        ("testAdultAgeRestrictions", testAdultAgeRestrictions),
        ("testAdultAgeEdgeCase", testAdultAgeEdgeCase),
        ("testNoLN", testNoLN),
        ("testNoFN", testNoFN),
        ("testFunctionNoFN", testFunctionNoFN),
        ("testFunctionNoLN", testFunctionNoLN)
    ]
}

class FamilyTests : XCTestCase {

    func testFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 1000)
    }
    
    
    // EC test 8: test not family spouse conditions: Double check if a person has spouse, it cannot become a family with Ted, nor the income would add that person's
    func testNonFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        let somebody = Person(firstName: "Charlotte", lastName: "Somebody", age: 20)
        somebody.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let family = Family(spouse1: ted, spouse2: charlotte)
        let notFamily = Family(spouse1: ted, spouse2: somebody)

        let familyIncome = family.householdIncome()
        let notFamilyIncome = notFamily.householdIncome()

        XCTAssert(familyIncome == 1000)
        XCTAssert(notFamilyIncome == 1000)
    }

    // EC test #9 : Test check family reversed situation, switched spouse 1 and 2 and still work
    func testNonFamily2() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        let somebody = Person(firstName: "Charlotte", lastName: "Somebody", age: 20)
        somebody.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let family = Family(spouse1: ted, spouse2: charlotte)
        let notFamily = Family(spouse1: somebody, spouse2: ted)

        let familyIncome = family.householdIncome()
        let notFamilyIncome = notFamily.householdIncome()

        XCTAssert(familyIncome == 1000)
        XCTAssert(notFamilyIncome == 1000)
    }
    
    
    func testFamilyWithKids() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))

        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 12000)
    }

    static var allTests = [
        ("testFamily", testFamily),
        ("testFamilyWithKids", testFamilyWithKids),
        ("testNonFamily", testNonFamily),
        ("testNonFamily2", testNonFamily2)
    ]
}
