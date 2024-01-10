//
//  MovieService.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Moya
import Combine
import CombineMoya
import InjectPropertyWrapper

protocol MovieServiceProtocol {
    func getMovies() -> AnyPublisher<Movies, Error>
    func getGenres() -> AnyPublisher<Genres, Error>
}

class MovieService: MovieServiceProtocol {

    @Inject
    var moya: MoyaProvider<MultiTarget>!

    func getMovies() -> AnyPublisher<Movies, Error> {
        let api = MultiTarget(HandleAPI.getMovies)

        print("User login url: \(api.baseURL)" + "\(api.path)")

        return moya.requestPublisher(api)
            .map(\.data)
            .decode(type: Movies.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getGenres() -> AnyPublisher<Genres, Error> {
        let api = MultiTarget(HandleAPI.getGenres)

        print("User login url: \(api.baseURL)" + "\(api.path)")

        return moya.requestPublisher(api)
            .map(\.data)
            .decode(type: Genres.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
