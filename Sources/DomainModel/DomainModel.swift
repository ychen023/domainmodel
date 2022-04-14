import Foundation
struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    let amount: Int
    let currency: String
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    enum Currency: String {
        case CAN = "CAN"
        case EUR = "EUR"
        case GBP = "GBP"
        case USD = "USD"
        
        func rate() -> Double {
            switch self {
                case .USD: return 1
                case .GBP: return 0.5
                case .EUR: return 1.5
                case .CAN: return 1.25
            }
        }
    }

    func convert(_ args: String) -> Money {
        guard let toCurr = Currency(rawValue: args) else {
            print("This currency is not in the bank")
            return self
        }
        
        let rn = Currency(rawValue: currency.self)
        var afterChange = amount
        if currency == "USD" {
            afterChange = (afterChange * (Int(toCurr.rate() * 100))) / 100
        } else {
            afterChange = (100 * amount) / Int(rn!.rate() * 100)
            print(afterChange)
        }
        return Money(amount: afterChange, currency: args)
    }
    
    func add(_ args: Money) -> Money {
        var sum: Int = 0
        let afterConvert = self.convert(args.currency)
        sum = sum + afterConvert.amount + args.amount
        print(sum)
        return Money(amount: sum, currency: args.currency)
    }
    
}

////////////////////////////////////
// Job
//
public class Job {
    var title: String
    var type: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    func calculateIncome(_ time: Int) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double) * time
        case .Salary(let uInt):
            return Int(uInt)
        }
    }
    
    func raise(byAmount: Double) {
        switch type {
        case .Hourly(let double):
            type = .Hourly(double + byAmount)
        case .Salary(let uInt):
            type = .Salary(uInt + UInt(byAmount))
        }
    }
    
    func raise(byPercent: Double) {
        switch type {
        case .Hourly(let double):
            type = .Hourly(double + double * byPercent)
        case .Salary(let uInt):
            type = .Salary(uInt + (uInt/10 * UInt(byPercent * 10)))
        }
    }
    
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String = ""
    var lastName : String = ""
    var age : Int = 0
    var jobStr : Job? = nil
    var spouseStr : Person? = nil
    
    init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(jobStr?.title ?? "nil") spouse:\(spouseStr?.firstName ?? "nil")]"
    }
    
    var job: Job? {
        get {
            return jobStr
        }
        set(newTitle) {
            if age < 16 {
                jobStr = nil
            } else {
                jobStr = newTitle
            }
        }
    }
    
    var spouse: Person? {
        get {
            return spouseStr
        }
        set(newName) {
            if age < 16 {
                spouseStr = nil
            } else {
                spouseStr = newName
            }
        }
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person] = []
    
    init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members = [spouse1, spouse2]
        } else {
            print("Not a family!")
        }
    }

    func householdIncome() -> Int {
        var income = 0
        for member in members {
            if member.job != nil {
                income = income + member.job!.calculateIncome(2200)
            }
        }
        return income
    }
    
    func haveChild(_ child: Person) -> Bool {
        if members[0].age > 21 || members[1].age > 21 {
            members.append(child)
            return true
        }
        return false
    }
    
}
