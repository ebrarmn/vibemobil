import Foundation

class ClubService {
    static let shared = ClubService()
    private var clubs: [Club] = []
    
    private init() {
        // Örnek veriler
        let club1 = Club(
            name: "Yazılım Kulübü",
            description: "Yazılım geliştirme ve teknoloji etkinlikleri düzenleyen öğrenci kulübü",
            presidentId: "user1",
            category: .technology
        )
        
        let club2 = Club(
            name: "Spor Kulübü",
            description: "Spor ve fitness etkinlikleri düzenleyen öğrenci kulübü",
            presidentId: "user2",
            category: .sports
        )
        
        clubs = [club1, club2]
    }
    
    func getAllClubs() -> [Club] {
        return clubs
    }
    
    func getClubById(_ id: String) -> Club? {
        return clubs.first { $0.id == id }
    }
    
    func createClub(_ club: Club) -> Bool {
        clubs.append(club)
        return true
    }
    
    func updateClub(_ club: Club) -> Bool {
        if let index = clubs.firstIndex(where: { $0.id == club.id }) {
            clubs[index] = club
            return true
        }
        return false
    }
    
    func deleteClub(_ id: String) -> Bool {
        if let index = clubs.firstIndex(where: { $0.id == id }) {
            clubs.remove(at: index)
            return true
        }
        return false
    }
    
    func addAnnouncement(to clubId: String, announcement: Announcement) -> Bool {
        if let index = clubs.firstIndex(where: { $0.id == clubId }) {
            clubs[index].announcements.append(announcement)
            return true
        }
        return false
    }
    
    func joinClub(clubId: String, userId: String) -> Bool {
        if let index = clubs.firstIndex(where: { $0.id == clubId }) {
            clubs[index].memberCount += 1
            return true
        }
        return false
    }
    
    func leaveClub(clubId: String, userId: String) -> Bool {
        if let index = clubs.firstIndex(where: { $0.id == clubId }) {
            clubs[index].memberCount -= 1
            return true
        }
        return false
    }
    
    func addSocialLink(to clubId: String, link: SocialLink) -> Bool {
        if let index = clubs.firstIndex(where: { $0.id == clubId }) {
            clubs[index].socialLinks.append(link)
            return true
        }
        return false
    }
    
    func getClubsByCategory(_ category: ClubCategory) -> [Club] {
        return clubs.filter { $0.category == category }
    }
    
    func searchClubs(query: String) -> [Club] {
        return clubs.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.description.lowercased().contains(query.lowercased())
        }
    }
} 