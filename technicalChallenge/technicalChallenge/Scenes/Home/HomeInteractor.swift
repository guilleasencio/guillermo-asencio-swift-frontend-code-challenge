//
//  HomeInteractor.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

protocol HomeBusinessLogic {
  func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
  //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {

  var presenter: HomePresentationLogic?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Home.Something.Request) {
    let response = Home.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
