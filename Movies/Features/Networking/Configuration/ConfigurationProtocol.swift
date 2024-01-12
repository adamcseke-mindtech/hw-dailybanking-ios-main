//
//  ConfigurationProtocol.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation

protocol ConfigurationProtocol {
    static var endpoint: String { get }
    static var apiKey: String { get }
}
