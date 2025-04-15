import SwiftUI

struct MushroomListView: View {
    @StateObject var viewModel: MushroomListViewModel = MushroomListViewModel()
    @State private var showProfile = false

    var body: some View {
        NavigationView {
            List(viewModel.mushrooms) { mushroom in
                NavigationLink(destination: MushroomDetailView(mushroom: mushroom)) {
                    HStack {
                        Text(mushroom.name)
                        Spacer()
                        AsyncImage(url: URL(string: mushroom.profilePicture)) { image in
                            image.resizable().frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("Mushrooms")
            .toolbar {
                Button("Profile") {
                    showProfile.toggle()
                }
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
            .onAppear { viewModel.fetchMushrooms() }
        }
    }
}
#Preview {
    MushroomListView()
}