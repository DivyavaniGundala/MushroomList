import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                Button("Login") {
                    viewModel.login()
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }

                NavigationLink(
                    destination: MushroomListView(
                        viewModel: MushroomListViewModel(apiService: APIService.shared)
                    ),
                    isActive: $viewModel.isLoggedIn
                ) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}
