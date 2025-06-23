import Foundation

class GameListViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var searchText: String = ""

    var filteredGames: [Game] {
        if searchText.isEmpty {
            return games
        } else {
            return games.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }


    func fetchGames() {
        isLoading = true
        APIService.shared.fetchGames { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let games):
                    self?.games = games
                case .failure(let error):
                    print("❌ Error: \(error.localizedDescription)")
                    self?.games = []
                }
            }
        }
    }
}
