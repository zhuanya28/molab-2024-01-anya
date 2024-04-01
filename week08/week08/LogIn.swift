import SwiftUI

struct LogInPage: View {
    @EnvironmentObject var pageModel: PageModel
    @State private var inputUsername: String = ""

    var body: some View {
        VStack {
            Spacer()
            Text("Welcome, \(pageModel.username)")

            TextField("Enter your username", text: $inputUsername)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Button(action: {
                    if !inputUsername.isEmpty {
                        pageModel.username = inputUsername
                        pageModel.pageTag = .Page1
                    }
                }) {
                    Text("Set name")
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(.blue)
            }

            Spacer()
        }
        .padding()
    }
}

