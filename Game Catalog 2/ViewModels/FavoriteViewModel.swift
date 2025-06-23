import Foundation
import CoreData

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [GameEntity] = []

    private let context = CoreDataManager.shared.container.viewContext

    func fetchFavorites() {
        favorites = CoreDataManager.shared.fetchFavorites(context: context)
    }

    func removeFavorite(_ game: GameEntity) {
        CoreDataManager.shared.removeFavorite(game: game, context: context)
        fetchFavorites()
    }
}
