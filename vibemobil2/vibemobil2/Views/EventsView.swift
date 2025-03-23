import SwiftUI

struct AllEventsView: View {
    @State private var showingCreateEventSheet = false
    @State private var events: [Event] = Event.sampleEvents // Örnek verileri kullanıyoruz
    
    var body: some View {
        NavigationView {
            List(events) { event in
                EventRow(event: event)
            }
            .navigationTitle("Etkinlikler")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateEventSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingCreateEventSheet) {
                CreateEventView { newEvent in
                    events.append(newEvent)
                }
            }
        }
    }
}

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(event.title)
                .font(.headline)
            
            Text(event.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            HStack {
                Label(event.date.formatted(date: .abbreviated, time: .shortened),
                      systemImage: "calendar")
                
                Spacer()
                
                Label("\(event.attendees.count)", systemImage: "person.fill")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct CreateEventView: View {
    @Environment(\.dismiss) var dismiss
    let onEventCreated: (Event) -> Void
    
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var location = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Etkinlik Bilgileri")) {
                    TextField("Başlık", text: $title)
                    TextEditor(text: $description)
                        .frame(height: 100)
                    DatePicker("Tarih", selection: $date)
                    TextField("Konum", text: $location)
                }
            }
            .navigationTitle("Yeni Etkinlik")
            .navigationBarItems(
                leading: Button("İptal") { dismiss() },
                trailing: Button("Oluştur") {
                    let newEvent = createEvent()
                    onEventCreated(newEvent)
                    dismiss()
                }
                .disabled(title.isEmpty || description.isEmpty || location.isEmpty)
            )
        }
    }
    
    private func createEvent() -> Event {
        return Event(
            title: title,
            description: description,
            date: date,
            location: location,
            organizerId: UserService.shared.getCurrentUserId() ?? "",
            clubId: nil // Kulüp etkinliği değilse nil olabilir
        )
    }
}

#Preview {
    AllEventsView()
} 