import Foundation

class DatabaseService {
    static let shared = DatabaseService()
    
    private init() {
        setupDatabase()
    }
    
    private func setupDatabase() {
        // Şimdilik boş bırakıyoruz
        print("Veritabanı bağlantısı kurulacak")
    }
} 