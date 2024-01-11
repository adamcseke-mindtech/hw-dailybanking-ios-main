//
//  MarkManager.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Combine

//protocol MarkManagerProtocol {
//    func contains(_ movie: MovieVM) -> Bool
//    func add(_ movie: MovieVM)
//    func remove(_ movie: MovieVM)
//}

//class MarkManager: MarkManagerProtocol {
//    var movies: Set<String>
//
//    init() {
//        movies = []
//    }
//
//    func contains(_ movie: MovieVM) -> Bool {
//        movies.contains(movie.id)
//    }
//
//    func add(_ movie: MovieVM) {
////        objectWillChange.send()
//        movies.insert(movie.id)
//    }
//
//    func remove(_ movie: MovieVM) {
////        objectWillChange.send()
//        movies.remove(movie.id)
//    }
//}

class MarkManager: ObservableObject {
    var movieIds: Set<String>

    let objectDidChange = PassthroughSubject<Void, Never>()

    init() {
        movieIds = []
    }

    func containsMovieId(_ movieId: String) -> Bool {
        movieIds.contains(movieId)
    }

    func add(_ movie: MovieVM) {
        movieIds.insert(movie.id)
        objectDidChange.send()
    }

    func remove(_ movie: MovieVM) {
        movieIds.remove(movie.id)
        objectDidChange.send()
    }
}
