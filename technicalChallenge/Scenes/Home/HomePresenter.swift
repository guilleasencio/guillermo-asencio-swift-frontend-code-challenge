//
//  HomePresenter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

protocol HomePresentationLogic {
    func presentUserDetails(response: Home.UserDetails.Response)
}

class HomePresenter: HomePresentationLogic {

    var viewController: HomeDisplayLogic?

    // MARK: Public

    func presentUserDetails(response: Home.UserDetails.Response) {
        let viewModel = Home.UserDetails.ViewModel(errorMessage: response.errorMessage)
        viewController?.displayUserDetails(viewModel: viewModel)
    }
}
