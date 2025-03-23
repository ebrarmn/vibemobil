import Foundation
import SwiftUI

class ClubViewModel: ObservableObject {
    @Published var clubs: [Club] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    init() {
        // Şimdilik örnek verileri kullanıyoruz
        loadSampleClubs()
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
    
    func addClub(_ club: Club) {
        // MongoDB'ye kulüp ekleme işlemi burada yapılacak
        clubs.append(club)
    }
    
    func updateClub(_ club: Club) {
        // MongoDB'de kulüp güncelleme işlemi burada yapılacak
        if let index = clubs.firstIndex(where: { $0.id == club.id }) {
            clubs[index] = club
        }
    }
    
    func deleteClub(_ club: Club) {
        // MongoDB'den kulüp silme işlemi burada yapılacak
        clubs.removeAll { $0.id == club.id }
    }
} 