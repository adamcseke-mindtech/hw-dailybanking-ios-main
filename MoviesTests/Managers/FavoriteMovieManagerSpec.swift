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
            var sut: MarkManager!
            var assembler: MainAssembler!
            var emittedMovie: MovieVM!

            beforeEach {
                assembler = MainAssembler.create(withAssemblies: [TestAssembly()])
                InjectSettings.resolver = assembler.container
                sut = assembler.resolver.resolve(MarkManager.self)
                emittedMovie = MovieVM(id: "id", title: "", genres: "", overView: "", image: .init(small: "", large: ""), popularity: 0.0, isMarked: false)
            }

            afterEach {
                sut = nil
                assembler.dispose()
                emittedMovie = nil
            }


            context("when no marked  movie") {
                beforeEach {
                    sut.movieIds = []
                }

                it("cheks movies count is 0") {
                    expect(sut.movieIds.count).to(equal(0))
                }
            }

            context("when mark a movie") {
                beforeEach {
                    sut.add(emittedMovie)
                }

                it("checks if movie marked") {
                    expect(sut.containsMovieId(emittedMovie.id)).toNot(beNil())
                }
            }

            context("when requested to remove a movie") {
                beforeEach {
                    sut.remove(emittedMovie)
                }

                it("checks if movie marked") {
                    expect(sut.containsMovieId(emittedMovie.id)).to(beFalse())
                }
            }
        }
    }
}

extension FavoriteMovieManagerSpec {
    class TestAssembly: Assembly {

        func assemble(container: Container) {

            container.register(MarkManager.self) { _ in
                return MarkManager()
            }.inObjectScope(.transient)
        }
    }
}
