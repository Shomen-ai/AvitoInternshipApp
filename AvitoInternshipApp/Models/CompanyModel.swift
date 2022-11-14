import Foundation

struct Company: Decodable {
    var company: InfoCompany
}

struct InfoCompany: Decodable {
    let name: String
    var employees: [Employees]
}

struct Employees: Decodable {
    let name: String
    let phone_number: String
    let skills: [String]
}

class CashedCompany {
    var company: Company
    
    init(company: Company) {
        self.company = company
    }
}
