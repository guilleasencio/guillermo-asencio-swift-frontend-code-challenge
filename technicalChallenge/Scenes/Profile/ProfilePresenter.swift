//
//  ProfilePresenter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentSomething(response: Profile.Something.Response)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?

    // MARK: Do something

    func presentSomething(response: Profile.Something.Response) {
        let viewModel = Profile.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
