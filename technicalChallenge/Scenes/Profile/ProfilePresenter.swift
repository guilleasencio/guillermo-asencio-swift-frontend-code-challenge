//
//  ProfilePresenter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Domain
import UIKit

protocol ProfilePresentationLogic {
    func presentData(response: Profile.Data.Response)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?

    // MARK: - Public

    func presentData(response: Profile.Data.Response) {
        let viewState: ProfileDataViewState
        switch response.state {
        case .success(let user, let repositories):
            let headerViewData = ProfileHeaderViewData(name: user.username,
                                                       avatar: user.avatar)
            let cellData = getCellData(repositories: repositories)
            viewState = .success(headerViewData: headerViewData, cellData: cellData)
        case .error(let message):
            viewState = .error(message: message)
        }
        let viewModel = Profile.Data.ViewModel(viewState: viewState)
        viewController?.displayData(viewModel: viewModel)
    }

    // MARK: - Private

    private func getCellData(repositories: [Repository]) -> [RepositoryViewCellData] {
        repositories.map {
            RepositoryViewCellData(name: $0.name, language: $0.language)
        }
    }
}
