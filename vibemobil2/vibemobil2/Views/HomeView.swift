import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ClubsView()
                .tabItem {
                    Label("Kulüpler", systemImage: "building.2.fill")
                }
            
            AllEventsView()
                .tabItem {
                    Label("Etkinlikler", systemImage: "calendar")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.circle.fill")
                }
        }
    }
}

struct clubsView: View {
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

struct ProfileView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Profil Bilgileri")) {
                    if let user = userViewModel.currentUser {
                        Text(user.name)
                        Text(user.email)
                    } else {
                        Text("Giriş yapılmadı")
                    }
                }
                
                Section(header: Text("Ayarlar")) {
                    Button("Çıkış Yap") {
                        userViewModel.logout()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Profil")
        }
    }
}

#Preview {
    HomeView()
} 
