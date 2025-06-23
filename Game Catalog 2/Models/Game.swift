import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    let name: String
    let released: String?
    let rating: Double
    let background_image: String?
}
