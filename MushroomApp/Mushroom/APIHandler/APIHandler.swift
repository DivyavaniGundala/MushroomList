import Combine
import Foundation

import Combine

protocol APIServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error>
    func fetchMushrooms() -> AnyPublisher<MushroomModel, Error>
    func fetchUserProfile() -> AnyPublisher<User, Error>
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    private init() {}

    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error> {
        let url = URL(string: "http://demo5845085.mockable.io/api/v1/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(["email": email, "password": password])

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: LoginModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchMushrooms() -> AnyPublisher<MushroomModel, Error> {
        let url = URL(string: "http://demo5845085.mockable.io/api/v1/mushrooms")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MushroomModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchUserProfile() -> AnyPublisher<User, Error> {
        let url = URL(string: "http://demo5845085.mockable.io/users/me")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
