import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    private let apiKey = AppEnvironment.shared.get("API_KEY") ?? ""

    func fetchGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        guard let url = URL(string: "https://api.rawg.io/api/games?key=\(apiKey)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(GameResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
        guard let url = URL(string: "https://api.rawg.io/api/games/\(id)?key=\(apiKey)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let detail = try JSONDecoder().decode(GameDetail.self, from: data)
                completion(.success(detail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
