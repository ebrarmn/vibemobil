import SwiftUI

struct ClubDetailView: View {
    let club: Club
    @State private var selectedTab = 0
    @State private var showingNewAnnouncementSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                HeaderView(club: club)
                
                // Tab Bar
                CustomTabBar(selectedTab: $selectedTab)
                
                // Tab Content
                TabView(selection: $selectedTab) {
                    AnnouncementsView(club: club)
                        .tag(0)
                    
                    ClubEventsView(club: club)
                        .tag(1)
                    
                    MembersView(club: club)
                        .tag(2)
                    
                    AboutView(club: club)
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if club.presidentId == UserService.shared.getCurrentUserId() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingNewAnnouncementSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewAnnouncementSheet) {
            NewAnnouncementView(club: club)
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    let club: Club
    
    var body: some View {
        VStack(spacing: 16) {
            // Kulüp Resmi
            if let imageURL = club.imageURL {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(spacing: 8) {
                Text(club.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(club.category.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                HStack(spacing: 20) {
                    StatView(value: "\(club.memberCount)", title: "Üye")
                    StatView(value: "\(club.announcements.count)", title: "Duyuru")
                }
                .padding(.top, 8)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    private let tabs = ["Duyurular", "Etkinlikler", "Üyeler", "Hakkında"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    TabButton(
                        text: tabs[index],
                        isSelected: selectedTab == index
                    ) {
                        selectedTab = index
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct TabButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .blue : .gray)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(isSelected ? .blue : .clear)
                        .offset(y: 4)
                )
        }
    }
}

// MARK: - Stat View
struct StatView: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Tab Content Views
struct AnnouncementsView: View {
    let club: Club
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if club.announcements.isEmpty {
                Text("Henüz duyuru bulunmuyor")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            } else {
                ForEach(club.announcements) { announcement in
                    AnnouncementCard(announcement: announcement)
                }
            }
        }
        .padding()
    }
}

struct ClubEventsView: View {
    let club: Club
    
    var body: some View {
        VStack {
            Text("Etkinlikler")
                .font(.headline)
                .padding()
            
            Text("Etkinlikler yakında...")
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct MembersView: View {
    let club: Club
    
    var body: some View {
        VStack {
            Text("\(club.memberCount) Üye")
                .font(.headline)
                .padding()
            
            Text("Üye listesi yakında...")
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct AboutView: View {
    let club: Club
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Açıklama")
                .font(.headline)
            
            Text(club.description)
                .foregroundColor(.secondary)
            
            if !club.socialLinks.isEmpty {
                Text("Sosyal Medya")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(club.socialLinks) { link in
                    Link(destination: URL(string: link.url) ?? URL(string: "https://example.com")!) {
                        HStack {
                            Image(systemName: socialIcon(for: link.platform))
                            Text(link.platform.rawValue.capitalized)
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding()
    }
    
    private func socialIcon(for platform: SocialPlatform) -> String {
        switch platform {
        case .instagram: return "camera.circle.fill"
        case .twitter: return "message.circle.fill"
        case .linkedin: return "briefcase.circle.fill"
        case .website: return "globe"
        case .youtube: return "play.circle.fill"
        }
    }
}

// MARK: - Announcement Card
struct AnnouncementCard: View {
    let announcement: Announcement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(announcement.title)
                .font(.headline)
            
            Text(announcement.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let imageURL = announcement.imageURL {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(8)
            }
            
            Text(announcement.createdAt, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - New Announcement View
struct NewAnnouncementView: View {
    let club: Club
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var imageURL = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Duyuru Bilgileri")) {
                    TextField("Başlık", text: $title)
                    TextEditor(text: $content)
                        .frame(height: 100)
                    TextField("Görsel URL (İsteğe Bağlı)", text: $imageURL)
                }
            }
            .navigationTitle("Yeni Duyuru")
            .navigationBarItems(
                leading: Button("İptal") { dismiss() },
                trailing: Button("Paylaş") {
                    createAnnouncement()
                    dismiss()
                }
                .disabled(title.isEmpty || content.isEmpty)
            )
        }
    }
    
    private func createAnnouncement() {
        let announcement = Announcement(
            title: title,
            content: content,
            imageURL: imageURL.isEmpty ? nil : imageURL
        )
        // TODO: Add announcement to club
    }
}

#Preview {
    NavigationView {
        ClubDetailView(club: Club.sampleClubs[0])
    }
} 