//
//  UserRepositoryFactory.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Domain
import Foundation

public enum UserRepositoryFactory {
    public static func make() -> UserRepository {
        let userDetailsDataSource = UserDetailsDataSourceFactory.make()
        return UserRepositoryImplementation(userDetailsDataSource: userDetailsDataSource)
    }
}
