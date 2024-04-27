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
            var errorMessage: String?
            var repositories: [Repository] = []
            do {
                repositories = try await getUserRepositoriesUseCase(username: user.username)
            } catch let error as CustomError {
                errorMessage = error.errorMessage
            } catch {
                errorMessage = error.localizedDescription
            }
            let response = Profile.Data.Response(user: user, repositories: repositories)
            presenter?.presentData(response: response)
        }
    }
}
