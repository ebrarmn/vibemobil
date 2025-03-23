import Foundation
import SwiftUI

class ClubViewModel: ObservableObject {
    @Published var clubs: [Club] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    init() {
        // Geçici olarak örnek verileri kullanıyoruz
        clubs = Club.sampleClubs
    }
    
    private func loadSampleClubs() {
        clubs = Club.sampleClubs
    }
    
    // İleride MongoDB entegrasyonu için kullanılacak fonksiyonlar
    func fetchClubs() {
        isLoading = true
        // MongoDB'den veri çekme işlemi burada yapılacak
        isLoading = false
    }
    
    func createClub(_ club: Club) {
        clubs.append(club)
        objectWillChange.send()
    }
    
    func updateClub(_ club: Club) {
        if let index = clubs.firstIndex(where: { $0.id == club.id }) {
            clubs[index] = club
            objectWillChange.send()
        }
    }
    
    func deleteClub(_ id: String) {
        clubs.removeAll { $0.id == id }
        objectWillChange.send()
    }
    
    func getClubsByCategory(_ category: ClubCategory) -> [Club] {
        clubs.filter { $0.category == category }
    }
    
    func searchClubs(query: String) -> [Club] {
        guard !query.isEmpty else { return clubs }
        return clubs.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.description.lowercased().contains(query.lowercased())
        }
    }
} 

