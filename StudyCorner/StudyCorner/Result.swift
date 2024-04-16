//
//  Result.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//

import Foundation
import SwiftUI

struct SearchResults: Codable {
    var total: Int
    var results: [SearchResult]
}

struct SearchResult: Codable {
    var id: String
    var description: String?
    var urls: URLs
}

struct URLs: Codable {
    var small: String
}
