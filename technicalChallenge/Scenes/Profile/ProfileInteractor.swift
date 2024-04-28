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
    private let getUserRepositoriesUseCase: GetUserRepositoriesUseCase

    init(getUserRepositoriesUseCase: GetUserRepositoriesUseCase) {
        self.getUserRepositoriesUseCase = getUserRepositoriesUseCase
    }

    var user: User?

    // MARK: - Public

    func loadData(request: Profile.Data.Request) {
        guard let user else {
            return
        }
        Task { @MainActor in
            let state: ProfileDataState
            do {
                let repositories = try await getUserRepositoriesUseCase(username: user.username)
                state = .success(user: user, repositories: repositories)
            } catch let error as CustomError {
                state = .error(message: error.errorMessage)
            } catch {
                state = .error(message: error.localizedDescription)
            }
            let response = Profile.Data.Response(state: state)
            presenter?.presentData(response: response)
        }
    }
}
