//
//  FavoriteMovies.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Combine

class FavoriteMovies: ObservableObject {
    private var movies: Set<String>
    private let saveKey = "Favorites"

    init() {
        movies = []
    }

    func contains(_ movie: MovieVM) -> Bool {
        movies.contains(movie.id)
    }

    func containsID(_ movieID: String) -> Bool {
        movies.contains(movieID)
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
