//
//  HomeRouter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToAlert(message: String)
    func routeToProfile()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {

    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    // MARK: Routing

    func routeToAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }

    func routeToProfile() {
        let destinationVC = ProfileViewControllerFactory.make()
        if let sourceDS = dataStore, var destinationDS = destinationVC.router?.dataStore {
          destinationDS.user = sourceDS.user
        }
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
