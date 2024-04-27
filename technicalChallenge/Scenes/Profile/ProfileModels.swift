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
            let user: User
            let repositories: [Repository]
        }

        struct ViewModel {
            let headerViewData: ProfileHeaderViewData
            let cellData: [RepositoryViewCellData]
        }
    }
}
