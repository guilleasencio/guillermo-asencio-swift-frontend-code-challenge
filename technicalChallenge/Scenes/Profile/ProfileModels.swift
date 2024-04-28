//
//  ProfileModels.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Domain
import Foundation

enum Profile {
    enum Data {
        struct Request {
        }

        struct Response {
            let state: ProfileDataState
        }

        struct ViewModel {
            let viewState: ProfileDataViewState
        }
    }
}

// MARK: - Business models

enum ProfileDataState {
    case success(user: User, repositories: [Repository])
    case error(message: String)
}

// MARK: - View models

enum ProfileDataViewState {
    case success(headerViewData: ProfileHeaderViewData, cellData: [RepositoryViewCellData])
    case error(message: String)
}
