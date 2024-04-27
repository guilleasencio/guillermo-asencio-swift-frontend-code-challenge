//
//  RepositoriesRepository.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

public protocol RepositoriesRepository: AnyObject {
    func getUserRepositories(for username: String) async throws -> [Repository]
}
