//
//  LogIn.swift
//  week06
//
//  Created by anya zhukova on 3/11/24.
//

// LogInPage.swift
import SwiftUI

struct LogIn: View {
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
                    NavigationLink(destination: StudyMusicPage(username: inputUsername)) {
                        Text("Log in")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if !inputUsername.isEmpty {
                            username = inputUsername
                        }
                    }

                    Button("Log out") {
                        username = "stranger"
                        inputUsername = ""
                    }
                    .foregroundColor(.red) // Set your desired color for Log out button
                    .disabled(username == "stranger") // Disable Log out button when not logged in
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login Page")
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}


