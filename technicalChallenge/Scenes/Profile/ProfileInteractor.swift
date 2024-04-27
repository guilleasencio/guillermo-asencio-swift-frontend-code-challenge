//
//  ProfileInteractor.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Domain
import Foundation

protocol ProfileBusinessLogic {
    func loadData(request: Profile.Data.Request)
}

protocol ProfileDataStore {
    var user: User? { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?

    var user: User?

    // MARK: - Public

    func loadData(request: Profile.Data.Request) {
        guard let user else {
            return
        }
        let response = Profile.Data.Response(user: user, repositories: [])
        presenter?.presentData(response: response)
    }
}
