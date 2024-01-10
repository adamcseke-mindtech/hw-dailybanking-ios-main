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

    @Published var movie: MovieVM
    private var cancellables: Set<AnyCancellable> = []

    init(movie: MovieVM) {
        self.movie = movie
    }

    func markMovie() {
    }
}
