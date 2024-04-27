//
//  ProfileInteractor.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Domain
import Foundation

protocol ProfileBusinessLogic {
    func doSomething(request: Profile.Something.Request)
}

protocol ProfileDataStore {
    var user: User? { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?

    var user: User?

    // MARK: Do something

    func doSomething(request: Profile.Something.Request) {
        let response = Profile.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
