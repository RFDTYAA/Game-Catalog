import Foundation

struct GameDetail: Codable {
    let id: Int
    let name: String
    let description_raw: String
    let released: String?
    let rating: Double
    let background_image: String?
}
