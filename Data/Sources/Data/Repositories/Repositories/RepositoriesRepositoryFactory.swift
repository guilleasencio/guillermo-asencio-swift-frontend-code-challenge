//
//  RepositoriesRepositoryFactory.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Domain
import Foundation

public enum RepositoriesRepositoryFactory {
    public static func make() -> RepositoriesRepository {
        let userRepositoriesDataSource = UserRepositoriesDataSourceFactory.make()
        return RepositoriesRepositoryImplementation(userRepositoriesDataSource: userRepositoriesDataSource)
    }
}
