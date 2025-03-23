import Foundation

struct Event: Identifiable {
    let id: String
    var title: String
    var description: String
    var clubId: String
    var startDate: Date
    var endDate: Date
    var location: String
    var imageURL: String?
    var participantCount: Int
    var maxParticipants: Int
    var createdAt: Date
    var updatedAt: Date
    
    // Örnek veri oluşturmak için
    static var sampleEvents: [Event] = [
        Event(id: "1",
              title: "Swift Workshop",
              description: "iOS geliştirme workshop'u",
              clubId: "1",
              startDate: Date().addingTimeInterval(86400),
              endDate: Date().addingTimeInterval(172800),
              location: "Bilgisayar Mühendisliği Binası",
              imageURL: nil,
              participantCount: 20,
              maxParticipants: 30,
              createdAt: Date(),
              updatedAt: Date()),
        Event(id: "2",
              title: "Fitness Challenge",
              description: "Haftalık fitness yarışması",
              clubId: "2",
              startDate: Date().addingTimeInterval(172800),
              endDate: Date().addingTimeInterval(259200),
              location: "Spor Salonu",
              imageURL: nil,
              participantCount: 15,
              maxParticipants: 25,
              createdAt: Date(),
              updatedAt: Date())
    ]
} 