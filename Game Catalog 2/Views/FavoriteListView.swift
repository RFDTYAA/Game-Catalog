import SwiftUI

struct FavoriteListView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        NavigationView {
            ZStack {
                Color.BackgroundColor.ignoresSafeArea()

                VStack {
                    if viewModel.favorites.isEmpty {
                        Spacer()
                        Text("Belum ada game favorit.")
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        List {
                            ForEach(viewModel.favorites) { gameEntity in
                                let game = Game(
                                    id: Int(gameEntity.id),
                                    name: gameEntity.name ?? "No Name",
                                    released: gameEntity.released,
                                    rating: gameEntity.rating,
                                    background_image: gameEntity.imageURL
                                )
                                
                                NavigationLink(destination: GameDetailView(game: game)) {
                                    GameRowFromEntityView(game: gameEntity)
                                }
                                .listRowBackground(Color.BackgroundColor)
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    let item = viewModel.favorites[index]
                                    viewModel.removeFavorite(item)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.BackgroundColor)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .onAppear {
                viewModel.fetchFavorites()
            }
            .navigationTitle("Favorit")
        }
    }
}

struct GameRowFromEntityView: View {
    let game: GameEntity

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: URL(string: game.imageURL ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Image("placeholder_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(10)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(game.name ?? "No Name")
                    .font(.headline)
                    .foregroundColor(.TextColor)

                Text("Released: \(game.released ?? "-")")
                    .font(.subheadline)
                    .foregroundColor(.highlightYellow)

                HStack {
                    Text("Rating = ")
                        .foregroundColor(.successGreen)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", game.rating))
                        .foregroundColor(.successGreen)
                }
                .font(.subheadline)
            }
        }
        .padding(.vertical, 6)
    }
}
