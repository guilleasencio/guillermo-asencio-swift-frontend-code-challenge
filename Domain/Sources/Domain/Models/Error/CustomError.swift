//
//  CustomError.swift
//
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public struct CustomError: Error, Equatable {
    public let errorCode: ErrorCode
    public let errorMessage: String

    public init(errorCode: ErrorCode, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}
