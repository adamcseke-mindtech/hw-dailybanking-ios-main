//
//  APIHandler.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import Moya

public enum APIHandler {
    case getMovies
    case getGenres
}

extension APIHandler: TargetType {
    public var baseURL: URL {
        return URL(string: Configuration.endpoint)!
    }

    public var path: String {
        switch self {
        case .getMovies:
            return "trending/movie/day"

        case .getGenres:
            return "genre/movie/list"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getMovies, .getGenres:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getMovies, .getGenres:
            let parameters: [String: Any] = [
                "api_key" : Configuration.apiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    public var validationType: ValidationType {
        return .successCodes
    }

    public var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }

    public var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
