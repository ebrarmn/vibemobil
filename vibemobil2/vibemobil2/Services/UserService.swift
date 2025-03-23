import Foundation
import MongoSwift

class UserService {
    static let shared = UserService()
    private let collection: MongoCollection<BSONDocument>?
    
    private init() {
        collection = DatabaseService.shared.getCollection("users")
    }
    
    func register(user: User) async throws -> Bool {
        guard let collection = collection else { return false }
        
        let document = try BSONEncoder().encode(user)
        try await collection.insertOne(document)
        return true
    }
    
    func login(email: String, password: String) async throws -> User? {
        guard let collection = collection else { return nil }
        
        let filter: BSONDocument = [
            "email": email,
            "password": password
        ]
        
        if let document = try await collection.findOne(filter) {
            return try BSONDecoder().decode(User.self, from: document)
        }
        return nil
    }
    
    func getUserById(_ id: BSONObjectID) async throws -> User? {
        guard let collection = collection else { return nil }
        
        let filter: BSONDocument = ["_id": id]
        
        if let document = try await collection.findOne(filter) {
            return try BSONDecoder().decode(User.self, from: document)
        }
        return nil
    }
} 