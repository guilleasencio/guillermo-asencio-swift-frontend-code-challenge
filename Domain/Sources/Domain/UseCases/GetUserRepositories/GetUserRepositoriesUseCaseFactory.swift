//
//  GetUserRepositoriesUseCaseFactory.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

public enum GetUserRepositoriesUseCaseFactory {
    public static func make(userRepository: UserRepository) -> GetUserRepositoriesUseCase {
        GetUserRepositoriesUseCaseImplementation(userRepository: userRepository)
    }
}
