//
//  UserRepositoriesDataSourceFactory.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

enum UserRepositoriesDataSourceFactory {
    static func make() -> UserRepositoriesDataSource {
        UserRepositoriesDataSourceImplementation(networkManager: NetworkManager.shared)
    }
}
