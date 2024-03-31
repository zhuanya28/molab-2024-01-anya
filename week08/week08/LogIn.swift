// LogInPage.swift


import SwiftUI

struct LogInPage: View {

    @AppStorage("username") var username: String = "stranger"
    @State private var inputUsername: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Welcome, \(username)")

                TextField("Enter your username", text: $inputUsername)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Button(action: {
                    }) {
                        Text("Set name")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if !inputUsername.isEmpty {
                            username = inputUsername
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login Page")
        }
    }
}

