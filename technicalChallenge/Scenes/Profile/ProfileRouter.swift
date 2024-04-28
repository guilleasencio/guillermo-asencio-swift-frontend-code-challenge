//
//  ProfileRouter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

protocol ProfileRoutingLogic {
    func routeToBack()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?

    // MARK: Routing

    func routeToBack() {
      viewController?.navigationController?.popViewController(animated: true)
    }
}
