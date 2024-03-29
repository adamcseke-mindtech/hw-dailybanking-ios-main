//
//  Movie.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

// swiftlint:disable line_length

import Foundation

// MARK: - Movie
struct Movie: Codable, Equatable {
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

extension Movie {
    func asMovieVM(genres: String, isMarked: Bool) -> MovieVM {
        MovieVM(id: String(id),
                title: title,
                genres: genres,
                overView: overview,
                image: MovieVM.Image(small: Constants.Poster.small + posterPath, large: Constants.Poster.original + posterPath),
                popularity: Float(popularity),
                isMarked: isMarked)
    }
}

// swiftlint:enable line_length
