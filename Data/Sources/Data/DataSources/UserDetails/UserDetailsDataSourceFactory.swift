//
//  UserDetailsDataSourceFactory.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

enum UserDetailsDataSourceFactory {
    static func make() -> UserDetailsDataSource {
        UserDetailsDataSourceImplementation(networkManager: NetworkManager.shared)
    }
}
