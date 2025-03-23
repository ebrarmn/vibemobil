import Foundation
import MongoSwift

class DatabaseService {
    static let shared = DatabaseService()
    private var client: MongoClient?
    
    private init() {
        setupConnection()
    }
    
    private func setupConnection() {
        do {
            let connectionString = "mongodb://localhost:27017"
            client = try MongoClient(connectionString)
            print("MongoDB bağlantısı başarılı!")
        } catch {
            print("MongoDB bağlantı hatası: \(error)")
        }
    }
    
    func getDatabase() -> MongoDatabase? {
        return client?.db("vibemobil")
    }
    
    func getCollection(_ name: String) -> MongoCollection<BSONDocument>? {
        return getDatabase()?.collection(name)
    }
} 