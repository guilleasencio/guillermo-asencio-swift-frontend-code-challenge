//
//  GetUserDetailsUseCaseFactory.swift
//
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public enum GetUserDetailsUseCaseFactory {
    public static func make(userRepository: UserRepository) -> GetUserDetailsUseCase {
        GetUserDetailsUseCaseImplementation(userRepository: userRepository)
    }
}
