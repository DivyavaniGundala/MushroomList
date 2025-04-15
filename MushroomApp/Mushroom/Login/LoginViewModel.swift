import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = "Test@gmail.com"
    @Published var password = "Test@1234"
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    func login() {
        guard isValidEmail(email), isValidPassword(password) else {
            errorMessage = "Invalid Email or Password"
            return
        }
        APIService.shared.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("errorerrorerror", error)
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { user in
                self.isLoggedIn = true
                print("SucessFull Login")
            })
            .store(in: &cancellables)
    }

    private func isValidEmail(_ email: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
    }
}
