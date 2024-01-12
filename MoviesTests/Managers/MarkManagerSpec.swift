//
//  MarkManagerSpec.swift
//  MoviesTests
//
//  Created by Adam Cseke on 10/01/2024.
//

// swiftlint:disable function_body_length

@testable import Movies
import Moya
import Combine
import Quick
import Nimble
import Mockingbird
import Swinject
import InjectPropertyWrapper

class MarkManagerSpec: QuickSpec {

    override func spec() {
        describe("MarkManager") {
            var sut: MarkManager!
            var assembler: MainAssembler!

            beforeEach {
                assembler = MainAssembler.create(withAssemblies: [TestAssembly()])
                InjectSettings.resolver = assembler.container
                sut = assembler.resolver.resolve(MarkManager.self)
            }

            afterEach {
                sut = nil
                assembler.dispose()
            }

            context("when Mark Manager is initialized") {
                var movie: MovieVM!

                beforeEach {
                    movie = MovieVM.any
                    sut.movieIds = []
                }

                context("when no marked movie") {

                    beforeEach {
                        sut.movieIds = []
                    }

                    it("should have no movies") {
                        expect(sut.movieIds.count).to(equal(0))
                    }
                }

                context("when requested to mark a movie") {
                    beforeEach {
                        sut.add(movie)
                    }

                    it("checks if movie marked") {
                        expect(sut.containsMovieId(movie.id)).to(beTrue())
                    }
                }

                context("when requested to remove a movie") {
                    beforeEach {
                        sut.add(movie)
                        sut.remove(movie)
                    }

                    it("checks if movie marked") {
                        expect(sut.containsMovieId(movie.id)).to(beFalse())
                    }
                }

                context("when a movie is added or removed") {
                    it("should send an update through objectDidChange") {
                        var changeFired = false
                        let cancellable = sut.objectDidChange.sink { changeFired = true }

                        sut.add(movie)
                        expect(changeFired).to(beTrue())

                        changeFired = false
                        sut.remove(movie)
                        expect(changeFired).to(beTrue())

                        cancellable.cancel()
                    }
                }
            }
        }
    }
}

extension MarkManagerSpec {
    class TestAssembly: Assembly {

        func assemble(container: Container) {

            container.register(MarkManager.self) { _ in
                return MarkManager()
            }.inObjectScope(.transient)
        }
    }
}

// swiftlint:enable function_body_length
