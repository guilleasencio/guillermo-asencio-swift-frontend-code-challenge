//
//  HomeViewController.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

protocol HomeDisplayLogic {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

  // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: Routing

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }

  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomething()
  }

  // MARK: Do something

  //@IBOutlet weak var nameTextField: UITextField!

  func doSomething() {
    let request = Home.Something.Request()
    interactor?.doSomething(request: request)
  }

  func displaySomething(viewModel: Home.Something.ViewModel) {
    //nameTextField.text = viewModel.name
  }
}
