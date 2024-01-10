//
//  Movies+Stub.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Foundation

extension Movies {
    static var any: Movies {
        Movies(
            page: 0,
            results: [],
            totalPages: 0,
            totalResults: 0
        )
    }
}
