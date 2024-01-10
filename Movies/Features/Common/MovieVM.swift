//
//  MovieVM.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

struct MovieVM: Identifiable, Equatable {
    struct Image: Equatable {
        let small: String
        let large: String
    }

    let id: String
    let title: String
    let genres: String
    let overView: String
    let image: Image
    let popularity: Float
}

extension MovieVM {
    func asMovie() -> Movie {
        Movie(
            genreIDS: [],
            id: Int(id) ?? 0,
            originalTitle: title,
            overview: overView,
            popularity: Double(popularity),
            posterPath: image.large,
            releaseDate: "",
            title: title)
    }
}
