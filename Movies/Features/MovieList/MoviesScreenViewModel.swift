//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation
import Moya
import Combine
import InjectPropertyWrapper

class MoviesScreenViewModel: ObservableObject, MoviesScreenViewModelProtocol {

    @Inject
    internal var movieService: MovieServiceProtocol

    @Inject
    var markManager: MarkManager

    @Published var movies: [MovieVM] = []
    @Published var genres: [Genre] = []
    @Published var errorText: String = ""

    private var cancellables = Set<AnyCancellable>()

    func getMovies() {
        movieService.getMovies()
            .mapError { error -> Error in
                self.errorText = error.localizedDescription
                return error
            }
            .map(\.self)
            .replaceError(with: Movies.empty)
            .sink(receiveValue: { movies in
                self.movies.removeAll()
                if !movies.results.isEmpty {
                    movies.results.forEach { movie in
                        self.movies.append(movie.asMovieVM(genres: self.getGenreNames(genreIDs: movie.genreIDS),
                                                           isMarked: self.markManager.containsMovieId(String(movie.id))))
                    }
                }
            })
            .store(in: &cancellables)
    }

    func getGenres() {
        movieService.getGenres()
            .mapError { error -> Error in
                self.errorText = error.localizedDescription
                return error
            }
            .map(\.self)
            .replaceError(with: Genres(genres: []))
            .sink(receiveValue: { genres in
                self.genres.removeAll()
                genres.genres.forEach { genre in
                    self.genres.append(genre)
                }
            })
            .store(in: &cancellables)
    }

    func getGenreNames(genreIDs: [Int]) -> String {
        var genreNames: [String] = []
        genreIDs.forEach { id in
            if let genre = self.genres.first(where: { $0.id == id }) {
                genreNames.append(genre.name)
            }
        }
        return genreNames.joined(separator: ", ")
    }
}
