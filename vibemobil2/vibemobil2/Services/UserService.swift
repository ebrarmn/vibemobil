import Foundation

class UserService {
    static let shared = UserService()
    private var users: [User] = []
    private var currentUserId: String?
    
    private init() {
        // Örnek kullanıcılar ekleyelim
        users = [
            User(name: "Admin", email: "admin@example.com", password: "admin123"),
            User(name: "Test User", email: "test@example.com", password: "test123")
        ]
    }
    
    func register(name: String, email: String, password: String) -> Bool {
        // Email kontrolü
        if users.contains(where: { $0.email == email }) {
            return false
        }
        
        let newUser = User(name: name, email: email, password: password)
        users.append(newUser)
        return true
    }
    
    func login(email: String, password: String) -> Bool {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            currentUserId = user.id
            return true
        }
        return false
    }
    
    func logout() {
        currentUserId = nil
    }
    
    func getCurrentUserId() -> String? {
        return currentUserId
    }
    
    func getUserById(_ id: String) -> User? {
        return users.first { $0.id == id }
    }
    
    func getCurrentUser() -> User? {
        guard let currentUserId = currentUserId else { return nil }
        return getUserById(currentUserId)
    }
} 