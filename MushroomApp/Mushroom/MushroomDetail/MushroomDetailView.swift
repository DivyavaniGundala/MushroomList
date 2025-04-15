import SwiftUI

struct MushroomDetailView: View {
    let mushroom: Mushroom
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: mushroom.profilePicture)) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }

            Text(mushroom.name)
                .font(.largeTitle)
                .padding()

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}
