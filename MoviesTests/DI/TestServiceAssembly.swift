//
//  TestServiceAssembly.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Swinject
import InjectPropertyWrapper
import Moya

class TestServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoyaProvider<MultiTarget>.self) { _ in
            return MoyaProvider<MultiTarget>(
                endpointClosure: self.createStubEndpoint,
                stubClosure: MoyaProvider.immediatelyStub,
                plugins: [NetworkLoggerPlugin(
                    configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        }.inObjectScope(.container)
    }

    func createStubEndpoint(withMultiTarget multiTarget: MultiTarget) -> Endpoint {
        fatalError("Need to override")
    }

    func url(_ target: TargetType) -> String {
        return target.baseURL.appendingPathComponent(target.path).absoluteString
    }

}
