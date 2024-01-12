//
//  ServiceAssembly.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Swinject
import Moya

class ServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(MovieServiceProtocol.self) { _ in
            return MovieService()
        }.inObjectScope(.transient)

        container.register(MoyaProvider<MultiTarget>.self) { _ in
            return MoyaProvider<MultiTarget>(plugins: [
                NetworkLoggerPlugin(
                    configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
            ])
        }.inObjectScope(.container)

    }
}
