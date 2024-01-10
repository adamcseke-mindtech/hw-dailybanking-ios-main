//
//  FavoriteMovieManager.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Combine

class FavoriteMovieManager: ObservableObject {
    var movies: Set<String>

    init() {
        movies = []
    }

    func contains(_ movie: MovieVM) -> Bool {
        movies.contains(movie.id)
    }

    func add(_ movie: MovieVM) {
        objectWillChange.send()
        movies.insert(movie.id)
    }

    func remove(_ movie: MovieVM) {
        objectWillChange.send()
        movies.remove(movie.id)
    }
}
