//
//  NetworkRequest.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Alamofire
import Foundation

enum Encoding {
    case json
    case url

    func parameterEncoding() -> ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}

protocol NetworkRequest {
    var httpMethod: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: Parameters? { get }
}

extension NetworkRequest {
    var httpMethod: HTTPMethod { .get }
    var encoding: ParameterEncoding { Encoding.json.parameterEncoding() }
    var headers: [String: String] { [:] }
    var parameters: Parameters? { nil }
}
