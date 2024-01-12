//
//  MoviesApp.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI
import Swinject
import InjectPropertyWrapper

@main
struct MoviesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MoviesScreen(viewModel: MoviesScreenViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let assembler: MainAssembler

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("Appdelegate -> open \(url)")
        return false
    }

    override init() {
        assembler = MainAssembler.create(withAssemblies: [
            ServiceAssembly(),
            ManagerAssembly()
        ])
        InjectSettings.resolver = assembler.container
    }

    init(withAssemblies assemblies: [Assembly]) {
        assembler = MainAssembler.create(withAssemblies: assemblies)
        InjectSettings.resolver = assembler.container
    }

    deinit {
        assembler.dispose()
    }
}
