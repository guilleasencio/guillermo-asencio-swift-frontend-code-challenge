//
//  NetworkManagerMock.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 29/4/24.
//

import Foundation
@testable import Data

class NetworkManagerMock: NetworkManagerLogic {
    
    var requestCalled = false
    var requestResponse: Data = Data("".utf8)
    var requestError: NetworkError?
    
    func request(_ request: any NetworkRequest) async throws -> Data {
        requestCalled = true
        if let requestError {
            throw requestError
        }
        return requestResponse
    }
}
