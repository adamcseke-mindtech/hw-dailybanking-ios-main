//
//  FavoriteMoviesTests.swift
//  MoviesTests
//
//  Created by Adam Cseke on 10/01/2024.
//

@testable import Movies
import XCTest

import Moya
import Combine
import Quick
import Nimble
import Moya
import Mockingbird
import Swinject
import InjectPropertyWrapper

class FavoriteMovieManagerSpec: QuickSpec {

    override func spec() {
        describe("FavoriteMovies") {
            var sut: FavoriteMovieManager!
            var assembler: MainAssembler!
            var emittedMovie: MovieVM!

            beforeEach {
                assembler = MainAssembler.create(withAssemblies: [TestAssembly()])
                InjectSettings.resolver = assembler.container
                sut = assembler.resolver.resolve(FavoriteMovieManager.self)
                emittedMovie = MovieVM(id: "id", title: "", genres: "", overView: "", image: .init(small: "", large: ""), popularity: 0.0)
            }

            afterEach {
                sut = nil
                assembler.dispose()
                emittedMovie = nil
            }


            context("when no marked  movie") {
                beforeEach {
                    sut.movies = []
                }

                it("cheks movies count is 0") {
                    expect(sut.movies.count).to(equal(0))
                }
            }

            context("when mark a movie") {
                beforeEach {
                    sut.add(emittedMovie)
                }

                it("checks if movie marked") {
                    expect(sut.contains(emittedMovie)).toNot(beNil())
                }
            }

            context("when requested to remove a movie") {
                beforeEach {
                    sut.remove(emittedMovie)
                }

                it("checks if movie marked") {
                    expect(sut.contains(emittedMovie)).to(beFalse())
                }
            }
        }
    }
}

extension FavoriteMovieManagerSpec {
    class TestAssembly: Assembly {

        func assemble(container: Container) {

            container.register(FavoriteMovieManager.self) { _ in
                return FavoriteMovieManager()
            }.inObjectScope(.transient)
        }
    }
}
