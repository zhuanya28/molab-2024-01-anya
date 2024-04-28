//
//  SearchObjectController.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
// heavily relying on this youtube video : https://www.youtube.com/watch?v=CmOe9vNopjU
//

// This one is where I make the request

import Foundation
import SwiftUI

class SearchObjectController: ObservableObject {
    static let shared = SearchObjectController()
    
    private init(){}
    var token = "BdS4JBpuZB-BAy6jss5Vgj2HuOsOGoyWmw3VVDZ00Os"
    @Published var results = [SearchResult]()
    @Published var searchText: String = "computer"
    
    func search() {
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText))")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(SearchResults.self, from: data)
                self.results.append(contentsOf: res.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

