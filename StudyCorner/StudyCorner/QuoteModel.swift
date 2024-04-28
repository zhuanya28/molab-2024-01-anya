//
//  QuoteModel.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/28/24.
//

import SwiftUI

struct Quote: Codable {
    let id: String
    let text: String
    let author: String

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


