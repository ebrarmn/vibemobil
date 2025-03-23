import SwiftUI

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    private let userService = UserService.shared
    
    init() {
        if let userId = userService.getCurrentUserId() {
            currentUser = userService.getUserById(userId)
        }
    }
    
    func login(email: String, password: String) -> Bool {
        let success = userService.login(email: email, password: password)
        if success {
            if let userId = userService.getCurrentUserId() {
                currentUser = userService.getUserById(userId)
            }
        }
        return success
    }
    
    func register(name: String, email: String, password: String) -> Bool {
        return userService.register(name: name, email: email, password: password)
    }
    
    func logout() {
        userService.logout()
        currentUser = nil
    }
    
    func updateProfile(name: String, email: String) {
        // TODO: Implement profile update
    }
} 