//
//  LaunchScreenView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/22/24.
//

import SwiftUI

struct Quote: Codable {
    let id: String
    let text: String
}

class QuoteViewModel: ObservableObject {
    @Published var quotes: [Quote] = []

    init() {
        loadQuotes()
    }

    func loadQuotes() {
        if let path = Bundle.main.path(forResource: "quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let quotesData = try decoder.decode([String: [Quote]].self, from: data)

                if let quotesArray = quotesData["quotes"] {
                    quotes = quotesArray
                } else {
                    print("Error: Could not find 'quotes' key in the JSON.")
                }
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
}

struct LaunchScreenView: View {
    @StateObject private var quoteViewModel = QuoteViewModel()
    @State private var currentQuote: String = ""
    
    var body: some View {
        VStack {
            Text("Study Corner")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
   
            Text(currentQuote)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            Button("Continue") {
          
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()

        .onAppear {
            regenerateQuote()
        }
    }
    
    private func regenerateQuote() {
        if let randomQuote = quoteViewModel.quotes.randomElement() {
            currentQuote = randomQuote.text
        }
    }
}



#Preview {
    LaunchScreenView()
}
