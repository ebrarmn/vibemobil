import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    init() {
        // Şimdilik örnek verileri kullanıyoruz
        loadSampleEvents()
    }
    
    private func loadSampleEvents() {
        events = Event.sampleEvents
    }
    
    // İleride MongoDB entegrasyonu için kullanılacak fonksiyonlar
    func fetchEvents() {
        isLoading = true
        // MongoDB'den veri çekme işlemi burada yapılacak
        isLoading = false
    }
    
    func addEvent(_ event: Event) {
        // MongoDB'ye etkinlik ekleme işlemi burada yapılacak
        events.append(event)
    }
    
    func updateEvent(_ event: Event) {
        // MongoDB'de etkinlik güncelleme işlemi burada yapılacak
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
        }
    }
    
    func deleteEvent(_ event: Event) {
        // MongoDB'den etkinlik silme işlemi burada yapılacak
        events.removeAll { $0.id == event.id }
    }
    
    func getEventsForClub(_ clubId: String) -> [Event] {
        return events.filter { $0.clubId == clubId }
    }
} 