//
//  NetworkManager.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Alamofire
import Foundation

protocol NetworkManagerLogic: AnyObject {
    func request(_ request: NetworkRequest) async throws -> Data
}

final actor NetworkManager: NetworkManagerLogic, GlobalActor {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com"
    private init() {}

    func request(_ request: NetworkRequest) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + request.path,
                       method: request.httpMethod,
                       parameters: request.parameters,
                       encoding: request.encoding,
                       headers: HTTPHeaders(request.headers)
            )
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        try self.checkHttpStatusCode(response.response?.statusCode)
                        continuation.resume(returning: data)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure:
                    continuation.resume(throwing: self.handleNetworkError())
                }
            }
        }
    }

    private func checkHttpStatusCode(_ statusCode: Int?) throws {
        guard let error = NetworkErrorCode.from(code: statusCode) else {
            return
        }

        switch error {
        case .notFound:
            throw NetworkError(errorCode: .notFound, errorMessage: "Resource Not Found.")
        default:
            throw NetworkError(errorCode: .badRequest, errorMessage: "Unknown error.")
        }
    }

    private func handleNetworkError() -> NetworkError {
        NetworkError(errorCode: .networkError,
                     errorMessage: "A network error has occurred. Check your Internet connection and try again later.")
    }
}
