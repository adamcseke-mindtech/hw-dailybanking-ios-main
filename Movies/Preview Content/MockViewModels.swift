//
//  MockViewModels.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MockViewModel: MoviesScreenViewModelProtocol {
    func getGenres() {}
    func isMovieMarked(movie: MovieVM) -> Bool { false }

    func getMovies() {}
    var movies: [MovieVM] = previewMovies
}

class MockMovieDetailsViewModel: MovieDetailsScreenViewModelProtocol {
    func isMovieMarked() -> Bool { false }
    let movie: MovieVM = previewMovies[0]

    func markMovie() {}
}
