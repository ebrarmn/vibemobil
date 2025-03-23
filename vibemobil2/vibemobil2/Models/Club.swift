import Foundation

struct Club: Identifiable {
    let id: String
    var name: String
    var description: String
    var imageURL: String?
    var memberCount: Int
    var presidentId: String
    var createdAt: Date
    var updatedAt: Date
    
    // Örnek veri oluşturmak için
    static var sampleClubs: [Club] = [
        Club(id: "1", 
             name: "Yazılım Kulübü", 
             description: "Yazılım geliştirme ve teknoloji etkinlikleri", 
             imageURL: nil, 
             memberCount: 50, 
             presidentId: "user1", 
             createdAt: Date(), 
             updatedAt: Date()),
        Club(id: "2", 
             name: "Spor Kulübü", 
             description: "Spor ve fitness etkinlikleri", 
             imageURL: nil, 
             memberCount: 75, 
             presidentId: "user2", 
             createdAt: Date(), 
             updatedAt: Date())
    ]
} 