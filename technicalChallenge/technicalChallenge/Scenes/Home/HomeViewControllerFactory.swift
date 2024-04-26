//
//  HomeViewControllerFactory.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import Foundation
import UIKit

enum HomeViewControllerFactory {

    static func make() -> UIViewController {
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
}
