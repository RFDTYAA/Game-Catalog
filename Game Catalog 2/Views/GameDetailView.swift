import SwiftUI

struct GameDetailView: View {
    let game: Game
    
    @StateObject private var viewModel = GameDetailViewModel()
    @Environment(\.managedObjectContext) private var context
    @State private var isFavorited: Bool = false
    
    private let customGray = Color(red: 0.63, green: 0.68, blue: 0.75)

    var body: some View {
        ZStack {
            Color.BackgroundColor.ignoresSafeArea()

            if let detail = viewModel.gameDetail {
                ScrollView {
                    
                    if let urlString = detail.background_image, let url = URL(string: urlString) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 250)
                                    .clipped()
                            } else {
                                Color.gray.opacity(0.3)
                                    .frame(height: 250)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(detail.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.TextColor)

                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", detail.rating))
                                .foregroundColor(.SuccessGreen)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Released: \(detail.released ?? "N/A")")
                                .font(.subheadline)
                                .foregroundColor(.HighlightYellow)
                        }
                        .padding(.top, 2)

                        Text("Deskripsi")
                            .font(.headline)
                            .foregroundColor(.TextColor)
                            .padding(.top, 8)

                        Text(detail.description_raw)
                            .font(.body)
                            .foregroundColor(customGray)
                        
                    }
                    .padding()

                }
                
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            }
        }
        .onAppear {
            if viewModel.gameDetail == nil {
                viewModel.fetchGameDetail(by: game.id)
            }
            isFavorited = CoreDataManager.shared.isGameFavorited(id: game.id, context: context)
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if viewModel.gameDetail != nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .foregroundColor(isFavorited ? .red : .gray)
                            .font(.system(size: 24))
                    }
                }
            }
        }
    }
    
    private func toggleFavorite() {
        isFavorited.toggle()
        if isFavorited, let detail = viewModel.gameDetail {
            let gameToSave = Game(id: detail.id, name: detail.name, released: detail.released, rating: detail.rating, background_image: detail.background_image)
            CoreDataManager.shared.addFavorite(game: gameToSave, context: context)
        } else {
            CoreDataManager.shared.removeFavoriteById(id: game.id, context: context)
        }
    }
}
