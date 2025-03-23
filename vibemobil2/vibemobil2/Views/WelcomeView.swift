import SwiftUI

struct WelcomeView: View {
    @State private var isShowingLogin = false
    @State private var isShowingRegister = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arka plan gradyanı
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Logo ve başlık
                    VStack(spacing: 20) {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                        
                        Text("VibeMobil")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Üniversite Kulüpleri ve Etkinlikleri")
                            .font(.system(size: 18))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    // Özellikler
                    VStack(spacing: 15) {
                        FeatureRow(icon: "calendar", text: "Etkinlikleri Keşfet")
                        FeatureRow(icon: "person.3", text: "Kulüplere Katıl")
                        FeatureRow(icon: "message", text: "Arkadaşlarınla Bağlantı Kur")
                        FeatureRow(icon: "bell", text: "Anlık Bildirimler Al")
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Butonlar
                    VStack(spacing: 15) {
                        Button(action: {
                            isShowingLogin = true
                        }) {
                            Text("Giriş Yap")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            isShowingRegister = true
                        }) {
                            Text("Kayıt Ol")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .sheet(isPresented: $isShowingLogin) {
                LoginView()
            }
            .sheet(isPresented: $isShowingRegister) {
                RegisterView()
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 40)
            
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
    }
}

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Giriş Yap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("E-posta", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Şifre", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // Şimdilik direkt ana sayfaya yönlendir
                    isLoggedIn = true
                }) {
                    Text("Giriş Yap")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarItems(leading: Button("İptal") {
                dismiss()
            })
            .fullScreenCover(isPresented: $isLoggedIn) {
                HomeView()
            }
        }
    }
}

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Kayıt Ol")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Ad Soyad", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("E-posta", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Şifre", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Şifre Tekrar", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // Şimdilik direkt ana sayfaya yönlendir
                    dismiss()
                }) {
                    Text("Kayıt Ol")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarItems(leading: Button("İptal") {
                dismiss()
            })
        }
    }
}

#Preview {
    WelcomeView()
} 