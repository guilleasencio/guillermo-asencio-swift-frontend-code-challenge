//
//  HomePresenter.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

protocol HomePresentationLogic {
  func presentSomething(response: Home.Something.Response)
}

class HomePresenter: HomePresentationLogic {

  var viewController: HomeDisplayLogic?

  // MARK: Do something

  func presentSomething(response: Home.Something.Response) {
    let viewModel = Home.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
