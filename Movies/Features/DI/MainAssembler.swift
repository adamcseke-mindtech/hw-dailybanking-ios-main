//
//  MainAssembler.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Swinject

class MainAssembler {
    public static var instance: MainAssembler! = nil

    var resolver: Resolver {
        return assembler.resolver
    }
    let container: Container
    private let assembler: Assembler

    private init(withAssemblies assemblies: [Assembly]) {
        container = Container()
        assembler = Assembler(container: container)
        assembler.apply(assemblies: assemblies)
    }

    /// Creates the single MainAssembler instance with the given assembly.
    /// IMPORTANT: this factory method SHOULD only be called once. Thereafter, use
    /// MainAssembler.instance to access the sibgleton instance that this method created.
    /// There SHOULD NOT be multiple ManAssembler and MainAssembly instances in the system!
    static func create(withAssemblies assemblies: [Assembly]) -> MainAssembler {
        instance = MainAssembler(withAssemblies: assemblies)
        return instance
    }

    deinit {
        print("deinit")
    }

    func dispose() {
        print("dispose")
    }
}
