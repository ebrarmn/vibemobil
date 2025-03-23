import Foundation
import MongoSwift

struct User: Codable {
    let _id: BSONObjectID
    var name: String
    var email: String
    var password: String
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String, email: String, password: String) {
        self._id = BSONObjectID()
        self.name = name
        self.email = email
        self.password = password
        self.createdAt = Date()
        self.updatedAt = Date()
    }
} 