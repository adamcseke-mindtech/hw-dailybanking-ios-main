//
//  Configuration.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation

class Configuration: ConfigurationProtocol {

    static var endpoint: String {
        return "https://api.themoviedb.org/3/"
    }

    static var apiKey: String {
        return "0b1a18e2b899d214aba36f03889b819e"
    }
}
