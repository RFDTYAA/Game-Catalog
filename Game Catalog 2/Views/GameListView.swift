import SwiftUI

struct GameListView: View {
    @StateObject private var viewModel = GameListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Game Catalog")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.TextColor)
                    .padding(.top, 24)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Cari game", text: $viewModel.searchText)
                        .foregroundColor(.white)
                }
                .padding(10)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Memuat data...")
                        .foregroundColor(.gray)
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    Spacer()
                } else if viewModel.filteredGames.isEmpty {
                    Spacer()
                    Text("Tidak ada game ditemukan.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(viewModel.filteredGames) { game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameRowView(game: game)
                        }
                        .listRowBackground(Color.BackgroundColor)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.BackgroundColor.ignoresSafeArea())
            .onAppear {
                if viewModel.games.isEmpty {
                    viewModel.fetchGames()
                }
            }
        }
    }
}
