//  LaunchScreenView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/22/24.
//

import SwiftUI


struct LaunchScreenView: View {
    @StateObject private var quoteViewModel = QuoteViewModel()
    @State private var currentQuote: String = ""
    @State private var currentAuthor: String = ""
    @State private var isShowingMainView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Study Corner")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                    
                
                Divider()
                    .frame(width: 70)
                    .background(Color.black)
                
                VStack {
                        Text(currentQuote)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom, 0)
                                   
                        Text("- \(currentAuthor)")
                        .fontWeight(.semibold)
                        .italic()
                        .padding(.top, 0
                                )
                        .padding(.bottom,10)
                               }
                Divider()
                    .frame(width: 40)
                    .background(Color.black)
                
                HStack{
                    NavigationLink(
                        destination: ContentView(),
                        label: {
                                    Label("Timer", systemImage: "clock")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .cornerRadius(8)
                                }
                    )
                    NavigationLink(
                        destination: RemindersMainView(),
                        label: {
                            Label("To-do list",  systemImage: "list.bullet")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(8)
                        }
                    )
                }
                .padding(.top, 20
                        )
            }
            .padding()
            .onAppear {
                regenerateQuote()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func regenerateQuote() {
        if let randomQuote = quoteViewModel.quotes.randomElement() {
            currentQuote = randomQuote.text
            currentAuthor = randomQuote.author
        }
    }
}

#Preview {
    LaunchScreenView()
}
