//
//  Genres.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
