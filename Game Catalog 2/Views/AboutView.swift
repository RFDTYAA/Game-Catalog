import SwiftUI

struct AboutView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showingEditProfile = false
    
    private let customGray = Color(red: 0.63, green: 0.68, blue: 0.75)

    var body: some View {
        NavigationView {
            ZStack {
                Color.BackgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        
                        Image("app_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                            .padding(.top, 40)

                        Text("Game Catalog")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.TextColor)

                        Text("Temukan berbagai game populer dan detailnya hanya dalam satu aplikasi. Dapatkan rating, genre, dan info lengkap secara real-time.")
                            .font(.body)
                            .foregroundColor(customGray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)

                        Spacer().frame(height: 30)
                        
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 6)
                        } else {
                            Image("profile_photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 6)
                        }

                        VStack(spacing: 6) {
                            Text("Dikembangkan oleh:")
                                .font(.headline)
                                .foregroundColor(.TextColor)

                            Text(viewModel.name)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.PrimaryBlue)

                            Text("Informatics Engineering - Darussalam Gontor University")
                                .font(.subheadline)
                                .foregroundColor(customGray)

                            Text("Wota & Tech Enthusiast")
                                .font(.footnote)
                                .italic()
                                .foregroundColor(customGray)
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        
                        Button("Edit Profil") {
                            showingEditProfile.toggle()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.PrimaryBlue) 
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)

                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView(viewModel: viewModel)
            }
        }
    }
}
