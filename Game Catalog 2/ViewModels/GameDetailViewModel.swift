import Foundation

class GameDetailViewModel: ObservableObject {
    @Published var gameDetail: GameDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchGameDetail(by id: Int) {
        isLoading = true
        errorMessage = nil
        
        APIService.shared.fetchGameDetail(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let detail):
                    self?.gameDetail = detail
                case .failure(let error):
                    self?.errorMessage = "Gagal memuat detail: \(error.localizedDescription)"
                }
            }
        }
    }
}
