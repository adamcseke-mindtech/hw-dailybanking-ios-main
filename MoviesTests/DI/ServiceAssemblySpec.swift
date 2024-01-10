//
//  ServiceAssemblySpec.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Nimble
import Quick
import Swinject
import Moya
import InjectPropertyWrapper

class ServiceAssemblySpec: QuickSpec {

    override func spec() {
        describe("ServiceAssembly") {
            var sut: ServiceAssembly!
            var container: Container!

            beforeEach {
                sut = ServiceAssembly()
                let assembler = MainAssembler.create(withAssemblies: [sut])
                container = assembler.container
                InjectSettings.resolver = container
            }

            afterEach {
                sut = nil
            }

            it("sut not nil") {
                expect(sut).toNot(beNil())
            }

            it("assembles \(MoyaProvider<MultiTarget>.self)") {
                expect(container.resolve(MoyaProvider<MultiTarget>.self)).toNot(beNil())
            }
        }
    }
}
