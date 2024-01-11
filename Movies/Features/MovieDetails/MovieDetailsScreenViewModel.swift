//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation
import Moya
import Combine
import InjectPropertyWrapper

class MovieDetailsScreenViewModel: ObservableObject, MovieDetailsScreenViewModelProtocol {

    @Inject
    var markManager: MarkManager

    @Published var movie: MovieVM
    private var cancellables: Set<AnyCancellable> = []

    init(movie: MovieVM) {
        self.movie = movie

        markManager.objectDidChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func markMovie() {
        if markManager.containsMovieId(movie.id) {
            markManager.remove(movie)
            movie.isMarked.toggle()
        } else {
            markManager.add(movie)
            movie.isMarked.toggle()
        }
    }


}
