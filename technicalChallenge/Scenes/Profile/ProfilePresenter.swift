//
//  ProfilePresenter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentData(response: Profile.Data.Response)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?

    // MARK: Do something

    func presentData(response: Profile.Data.Response) {
        let headerViewData = ProfileHeaderViewData(name: response.user.username,
                                                   avatar: response.user.avatar)
        let viewModel = Profile.Data.ViewModel(headerViewData: headerViewData)
        viewController?.displayData(viewModel: viewModel)
    }
}
