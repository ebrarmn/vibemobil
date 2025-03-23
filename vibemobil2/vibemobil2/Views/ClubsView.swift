import SwiftUI

struct ClubsView: View {
    @StateObject private var clubViewModel = ClubViewModel()
    @State private var selectedCategory: ClubCategory?
    @State private var searchText = ""
    @State private var showingCreateClubSheet = false
    
    private var filteredClubs: [Club] {
        let clubs = clubViewModel.clubs
        let searchFiltered = searchText.isEmpty ? clubs :
            clubs.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.description.lowercased().contains(searchText.lowercased())
            }
        
        if let category = selectedCategory {
            return searchFiltered.filter { $0.category == category }
        }
        return searchFiltered
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Kategori Seçici
                CategoryPicker(selectedCategory: $selectedCategory)
                
                // Kulüpler Listesi
                List(filteredClubs) { club in
                    NavigationLink(destination: ClubDetailView(club: club)) {
                        ClubRowView(club: club)
                    }
                }
            }
            .navigationTitle("Kulüpler")
            .searchable(text: $searchText, prompt: "Kulüp Ara")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateClubSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingCreateClubSheet) {
                CreateClubView()
            }
        }
    }
}

struct ClubRowView: View {
    let club: Club
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(club.name)
                .font(.headline)
            
            Text(club.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            HStack {
                CategoryLabel(text: club.category.rawValue)
                Spacer()
                Label("\(club.memberCount)", systemImage: "person.fill")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct CategoryPicker: View {
    @Binding var selectedCategory: ClubCategory?
    
    private let categories = ClubCategory.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                CategoryButton(
                    title: "Tümü",
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }
                
                ForEach(categories, id: \.self) { category in
                    CategoryButton(
                        title: category.rawValue,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

struct CategoryLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.blue)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
    }
}

struct CreateClubView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var description = ""
    @State private var category: ClubCategory = .other
    @State private var imageURL = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kulüp Bilgileri")) {
                    TextField("Kulüp Adı", text: $name)
                    TextEditor(text: $description)
                        .frame(height: 100)
                    
                    Picker("Kategori", selection: $category) {
                        ForEach(ClubCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    TextField("Görsel URL (İsteğe Bağlı)", text: $imageURL)
                }
            }
            .navigationTitle("Yeni Kulüp")
            .navigationBarItems(
                leading: Button("İptal") { dismiss() },
                trailing: Button("Oluştur") {
                    createClub()
                    dismiss()
                }
                .disabled(name.isEmpty || description.isEmpty)
            )
        }
    }
    
    private func createClub() {
        let newClub = Club(
            name: name,
            description: description,
            presidentId: UserService.shared.getCurrentUserId() ?? "",
            category: category
        )
        
        // TODO: Add club to database
    }
}

#Preview {
    ClubsView()
} 