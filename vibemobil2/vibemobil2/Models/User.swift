import Foundation

struct User: Codable {
    let id: String
    var name: String
    var email: String
    var password: String
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String, email: String, password: String) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.password = password
        self.createdAt = Date()
        self.updatedAt = Date()
    }
} 