import SwiftUI
import Combine

struct ProfileView: View {
    @State private var user: User?
    @State private var cancellable: AnyCancellable?

    var body: some View {
        VStack {
            if let user = user {
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
            } else {
                ProgressView().onAppear {
                    cancellable = APIService.shared.fetchUserProfile()
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { _ in }, receiveValue: { self.user = $0 })
                }
            }
        }
        .padding()
    }
}
