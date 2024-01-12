//
//  Movies.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation

// MARK: - Movies
struct Movies: Codable, Equatable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension Movies {
    static var empty: Movies {
        Movies(page: 0, results: [], totalPages: 0, totalResults: 0)
    }
}
