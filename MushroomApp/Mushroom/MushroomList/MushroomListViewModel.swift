import Combine
import SwiftUI
class MushroomListViewModel: ObservableObject {
    @Published var mushrooms: [Mushroom] = []
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }

    func fetchMushrooms() {
        apiService.fetchMushrooms()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching mushrooms:", error)
                }
            }, receiveValue: { [weak self] mushroomModels in
                self?.mushrooms = mushroomModels.mushrooms
            })
            .store(in: &cancellables)
    }
}

