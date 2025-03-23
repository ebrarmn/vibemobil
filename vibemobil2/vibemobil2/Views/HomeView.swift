import SwiftUI

struct HomeView: View {
    @StateObject private var clubViewModel = ClubViewModel()
    @StateObject private var eventViewModel = EventViewModel()
    
    var body: some View {
        TabView {
            ClubsView()
                .environmentObject(clubViewModel)
                .tabItem {
                    Label("Kulüpler", systemImage: "person.3.fill")
                }
            
            EventsView()
                .environmentObject(eventViewModel)
                .tabItem {
                    Label("Etkinlikler", systemImage: "calendar")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
        }
    }
}

struct ClubsView: View {
    @EnvironmentObject var clubViewModel: ClubViewModel
    
    var body: some View {
        NavigationView {
            List(clubViewModel.clubs) { club in
                VStack(alignment: .leading) {
                    Text(club.name)
                        .font(.headline)
                    Text(club.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Üye Sayısı: \(club.memberCount)")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Kulüpler")
        }
    }
}

struct EventsView: View {
    @EnvironmentObject var eventViewModel: EventViewModel
    
    var body: some View {
        NavigationView {
            List(eventViewModel.events) { event in
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)
                    Text(event.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "calendar")
                        Text(event.startDate, style: .date)
                        Text("-")
                        Text(event.endDate, style: .date)
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                    Text("Konum: \(event.location)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Katılımcı: \(event.participantCount)/\(event.maxParticipants)")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Etkinlikler")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Profil Bilgileri")) {
                    Text("Kullanıcı Adı")
                    Text("E-posta")
                    Text("Üye Olduğu Kulüpler")
                }
                
                Section(header: Text("Ayarlar")) {
                    Text("Bildirim Ayarları")
                    Text("Gizlilik Ayarları")
                    Text("Hesap Ayarları")
                }
            }
            .navigationTitle("Profil")
        }
    }
}

#Preview {
    HomeView()
} 