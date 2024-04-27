//
//  ProfileViewControllerFactory.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Data
import Domain
import Foundation
import UIKit

enum ProfileViewControllerFactory {
    static func make() -> ProfileViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()

        let userRepository = UserRepositoryFactory.make()
        let getUserRepositoriesUseCase = GetUserRepositoriesUseCaseFactory.make(userRepository: userRepository)
        let interactor = ProfileInteractor(getUserRepositoriesUseCase: getUserRepositoriesUseCase)

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
}
