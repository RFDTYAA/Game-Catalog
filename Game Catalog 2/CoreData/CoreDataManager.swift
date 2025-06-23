import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "FavoriteModel") // HARUS SAMA DENGAN NAMA FILE .xcdatamodeld

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ Failed to load Core Data stack: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("✅ Data saved successfully.")
        } catch {
            print("❌ Gagal menyimpan data Core Data: \(error.localizedDescription)")
        }
    }

    func addFavorite(game: Game, context: NSManagedObjectContext) {
        let newItem = GameEntity(context: context)
        newItem.id = Int64(game.id)
        newItem.name = game.name
        newItem.released = game.released
        newItem.rating = game.rating
        newItem.imageURL = game.background_image
        save(context: context)
    }

    func removeFavorite(game: GameEntity, context: NSManagedObjectContext) {
        context.delete(game)
        save(context: context)
    }

    func removeFavoriteById(id: Int, context: NSManagedObjectContext) {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
                save(context: context)
            }
        } catch {
            print("❌ Failed to fetch game to remove: \(error.localizedDescription)")
        }
    }

    func isGameFavorited(id: Int, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("❌ Gagal mengecek favorit: \(error.localizedDescription)")
            return false
        }
    }

    func fetchFavorites(context: NSManagedObjectContext) -> [GameEntity] {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        do {
            return try context.fetch(request)
        } catch {
            print("❌ Gagal fetch game favorit: \(error.localizedDescription)")
            return []
        }
    }
}
