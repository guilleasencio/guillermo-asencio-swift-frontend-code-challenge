//
//  UserRepository.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public protocol UserRepository: AnyObject {
    func getUserDetails(for username: String) async throws -> User
}
