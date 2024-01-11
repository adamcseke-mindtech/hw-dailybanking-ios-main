//
//  ManagerAssembly.swift
//  Movies
//
//  Created by Adam Cseke on 11/01/2024.
//

import Swinject

class ManagerAssembly: Assembly {

    // swiftlint:disable function_body_length
    func assemble(container: Container) {

        container.register(MarkManager.self) { _ in
            return MarkManager()
        }.inObjectScope(.container)

    }
}
