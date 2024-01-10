//
//  MovieVM+Stub.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Foundation

extension Movie {
    static var any: Movie {
        Movie(genreIDS: [], id: 0, originalTitle: "", overview: "", popularity: 0.0, posterPath: "", releaseDate: "", title: "")
    }
}
