//
//  MoviesScreenViewModelTests.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Moya
import Combine
import Quick
import Nimble
import Moya
import Mockingbird
import Swinject
import InjectPropertyWrapper

class MoviesScreenViewModelSpec: QuickSpec {

    override func spec() {
        describe("MoviesScreenViewModel") {
            var sut: MoviesScreenViewModel!
            var mockService: MovieServiceProtocolMock!
            var assembler: MainAssembler!
            var cancellable: Set<AnyCancellable>!

            var moviesResponse: PassthroughSubject<Movies, Error>!
            var emittedMovieItems: [Movie] = []

            beforeEach {
                assembler = MainAssembler.create(withAssemblies: [TestAssembly()])
                InjectSettings.resolver = assembler.container
                mockService = assembler.resolver.resolve(MovieServiceProtocol.self) as? MovieServiceProtocolMock
                sut = assembler.resolver.resolve(MoviesScreenViewModel.self)
                cancellable = Set<AnyCancellable>()

                moviesResponse = PassthroughSubject<Movies, Error>()
                given(mockService.getMovies()).willReturn(moviesResponse.eraseToAnyPublisher())

                emittedMovieItems.removeAll()
                sut.$movies.sink { completion in
                    switch completion {
                    case .finished:
                        print("Received finished")
                    case .failure(let error):
                        print("Received error: \(error)")
                    }
                } receiveValue: { movies in
                    movies.forEach { movieVM in
                        emittedMovieItems.append(movieVM.asMovie())
                    }
                }.store(in: &cancellable)

            }

            afterEach {
                sut = nil
                assembler.dispose()
                cancellable = nil
            }

            context("fetch Movies") {
                beforeEach {
                    sut.getMovies()
                }

                it("request to get movies from API") {
                    verify(mockService.getMovies()).wasCalled()
                }

                context("when received movies from API") {
                    var movies: Movies = Movies.any
                    beforeEach {
                        movies = Movies.any
                        moviesResponse.send(movies)
                    }

                    it("emits movie items") {
                        expect(emittedMovieItems).to(equal(movies.results))
                    }
                }
            }
        }
    }
}

extension MoviesScreenViewModelSpec {
    class TestAssembly: Assembly {

        func assemble(container: Container) {

            container.register(MoviesScreenViewModel.self) { _ in
                return MoviesScreenViewModel()
            }.inObjectScope(.transient)

            container.register(MovieServiceProtocol.self) { _ in
                let mock = mock(MovieServiceProtocol.self)
                return mock
            }.inObjectScope(.container)
        }
    }
}

