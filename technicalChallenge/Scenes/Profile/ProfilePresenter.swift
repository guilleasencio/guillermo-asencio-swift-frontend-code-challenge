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
        let headerViewData = ProfileHeaderViewData(name: response.user.username,
                                                   avatar: response.user.avatar)
        let viewModel = Profile.Data.ViewModel(headerViewData: headerViewData,
                                               cellData: getCellData(repositories: response.repositories))
        viewController?.displayData(viewModel: viewModel)
    }

    // MARK: - Private

    private func getCellData(repositories: [Repository]) -> [RepositoryViewCellData] {
        repositories.map {
            RepositoryViewCellData(name: $0.name, language: $0.language)
        }
    }
}
