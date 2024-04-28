//
//  HomeViewController.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

protocol HomeDisplayLogic {
    func displayUserDetails(viewModel: Home.UserDetails.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {

    // MARK: - Properties

    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

    private let sceneView = HomeView()

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: View lifecycle

    override func loadView() {
        view = sceneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavigationBar()
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "GitHub Viewer"
    }

    private func setupComponents() {
        registerForKeyboardNotifications()
        sceneView.delegate = self
    }

    // MARK: - Output

    func doGetUserDetails(term: String) {
        sceneView.setState(state: .loading)
        let request = Home.UserDetails.Request(term: term)
        interactor?.doGetUserDetails(request: request)
    }

    // MARK: - Input

    func displayUserDetails(viewModel: Home.UserDetails.ViewModel) {
        sceneView.setState(state: .loaded)
        guard let errorMessage = viewModel.errorMessage else {
            router?.routeToProfile()
            return
        }
        router?.routeToAlert(message: errorMessage)
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    func didTapSearchButton(term: String?) {
        guard let term else {
            return
        }
        doGetUserDetails(term: term)
    }
}

// MARK: - KeyboardHandler

extension HomeViewController {
    
    override func keyboardWillAppear(height: CGFloat, duration: TimeInterval, options: UIView.AnimationOptions) {
        if let screenHeight = view.window?.windowScene?.screen.bounds.size.height,
           let textFieldPoint = sceneView.searchTextField.globalPoint {
            var offSet = screenHeight - (textFieldPoint.y + sceneView.searchTextField.frame.size.height)
            offSet -= height
            if offSet < 0 {
                self.view.frame.origin.y = offSet - 18
            }
        }
    }
    
    override func keyboardWillDisappear(duration: TimeInterval, options: UIView.AnimationOptions) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
