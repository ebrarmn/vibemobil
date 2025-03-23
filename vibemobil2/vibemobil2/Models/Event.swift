import Foundation

struct Event: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let date: Date
    let location: String
    let organizerId: String
    let clubId: String?
    var attendees: [String] // Katılımcıların user ID'leri
    let createdAt: Date
    let updatedAt: Date
    
    init(title: String, description: String, date: Date, location: String, organizerId: String, clubId: String? = nil) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.date = date
        self.location = location
        self.organizerId = organizerId
        self.clubId = clubId
        self.attendees = []
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Sample Data
extension Event {
    static let sampleEvents = [
        Event(
            title: "Swift Workshop",
            description: "iOS uygulama geliştirme temelleri hakkında interaktif bir workshop.",
            date: Date().addingTimeInterval(7*24*60*60), // 1 hafta sonra
            location: "Bilgisayar Laboratuvarı",
            organizerId: "1",
            clubId: "1"
        ),
        Event(
            title: "Hackathon",
            description: "24 saatlik yazılım geliştirme maratonu.",
            date: Date().addingTimeInterval(14*24*60*60), // 2 hafta sonra
            location: "Ana Konferans Salonu",
            organizerId: "1",
            clubId: "1"
        )
    ]
} 