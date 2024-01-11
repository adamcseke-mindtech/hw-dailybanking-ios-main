//
//  MovieVM+Stub.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Foundation

extension MovieVM {
    static var any: MovieVM {
        MovieVM(
            id: "",
            title: "",
            genres: "",
            overView: "",
            image: .init(small: "", large: ""),
            popularity: 0.0,
            isMarked: false)
    }
}
