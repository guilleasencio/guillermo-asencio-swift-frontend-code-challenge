//
//  HomeViewControllerFactory.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import Data
import Domain
import Foundation
import UIKit

enum HomeViewControllerFactory {
    static func make() -> HomeViewController {
        let viewController = HomeViewController()
        let presenter = HomePresenter()
        let router = HomeRouter()

        let userRepository = UserRepositoryFactory.make()
        let getUserDetailsUseCase = GetUserDetailsUseCaseFactory.make(userRepository: userRepository)
        let interactor = HomeInteractor(getUserDetailsUseCase: getUserDetailsUseCase)

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
}
