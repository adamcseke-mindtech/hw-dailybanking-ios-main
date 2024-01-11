//
//  MovieDetailsScreenViewModelSpec.swift
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

class MovieDetailsScreenViewModelSpec: QuickSpec {

    override func spec() {
        describe("MovieDetailsScreenViewModel") {
            var sut: MovieDetailsScreenViewModel!
            var assembler: MainAssembler!
            var selectedMovie: MovieVM!

            beforeEach {
                assembler = MainAssembler.create(withAssemblies: [TestAssembly()])
                InjectSettings.resolver = assembler.container
                sut = assembler.resolver.resolve(MovieDetailsScreenViewModel.self)
                selectedMovie = sut.movie
            }

            afterEach {
                sut = nil
                assembler.dispose()
            }

            context("when a movie is selected") {
                var movie: MovieVM!

                beforeEach {
                    movie = MovieVM.any
                }

                it("should have a non-nil movie when initialized") {
                    expect(sut.movie).toNot(beNil())
                }

                context("when mark the movie") {

                    beforeEach {
                        sut.movie.isMarked = false
                        sut.markMovie()
                    }

                    it("marked the movie") {
                        expect(sut.movie.isMarked).to(beTrue())
                        expect(selectedMovie.id).to(equal(movie.id))
                    }
                }

                context("when remove the movie") {

                    beforeEach {
                        sut.movie.isMarked = true
                        sut.markMovie()
                    }

                    it("removed the movie") {
                        expect(sut.movie.isMarked).to(beFalse())
                        expect(selectedMovie.id).to(equal(movie.id))
                    }
                }
            }
        }
    }
}

extension MovieDetailsScreenViewModelSpec {
    class TestAssembly: Assembly {

        func assemble(container: Container) {

            container.register(MovieDetailsScreenViewModel.self) { _ in
                return MovieDetailsScreenViewModel(movie: MovieVM.any)
            }.inObjectScope(.transient)

            container.register(MarkManager.self) { _ in
                return MarkManager()
            }.inObjectScope(.transient)
        }
    }
}

