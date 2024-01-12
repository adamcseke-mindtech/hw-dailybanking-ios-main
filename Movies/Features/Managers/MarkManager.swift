//
//  MarkManager.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Combine

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
