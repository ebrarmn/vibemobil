import Foundation

struct Club: Identifiable, Codable {
    let id: String
    var name: String
    var description: String
    var imageURL: String?
    var presidentId: String
    var memberCount: Int
    var category: ClubCategory
    var socialLinks: [SocialLink]
    var announcements: [Announcement]
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String, description: String, presidentId: String, category: ClubCategory) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.presidentId = presidentId
        self.memberCount = 0
        self.category = category
        self.socialLinks = []
        self.announcements = []
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    init(id: String, name: String, description: String, imageURL: String?, presidentId: String, memberCount: Int, category: ClubCategory, socialLinks: [SocialLink], announcements: [Announcement], createdAt: Date, updatedAt: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.presidentId = presidentId
        self.memberCount = memberCount
        self.category = category
        self.socialLinks = socialLinks
        self.announcements = announcements
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Örnek veri oluşturmak için
    static var sampleClubs: [Club] = [
        Club(id: "1", 
             name: "Yazılım Kulübü", 
             description: "Yazılım geliştirme ve teknoloji etkinlikleri", 
             imageURL: nil, 
             presidentId: "user1", 
             memberCount: 50, 
             category: .technology, 
             socialLinks: [], 
             announcements: [], 
             createdAt: Date(), 
             updatedAt: Date()),
        Club(id: "2", 
             name: "Spor Kulübü", 
             description: "Spor ve fitness etkinlikleri", 
             imageURL: nil, 
             presidentId: "user2", 
             memberCount: 75, 
             category: .sports, 
             socialLinks: [], 
             announcements: [], 
             createdAt: Date(), 
             updatedAt: Date())
    ]
}

enum ClubCategory: String, Codable, CaseIterable {
    case academic = "Akademik"
    case sports = "Spor"
    case culture = "Kültür"
    case art = "Sanat"
    case technology = "Teknoloji"
    case social = "Sosyal"
    case other = "Diğer"
}

struct SocialLink: Codable, Identifiable {
    var id: String { platform.rawValue }
    let platform: SocialPlatform
    let url: String
}

enum SocialPlatform: String, Codable {
    case instagram
    case twitter
    case linkedin
    case website
    case youtube
}

struct Announcement: Identifiable, Codable {
    let id: String
    let title: String
    let content: String
    let createdAt: Date
    var imageURL: String?
    
    init(title: String, content: String, imageURL: String? = nil) {
        self.id = UUID().uuidString
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.createdAt = Date()
    }
} 