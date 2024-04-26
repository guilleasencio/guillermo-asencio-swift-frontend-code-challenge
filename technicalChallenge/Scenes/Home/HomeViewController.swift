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

    override func loadView() {
        view = sceneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupComponents()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "GitHub Viewer"
    }

    private func setupComponents() {
        sceneView.delegate = self
    }

    // MARK: Do something

    func doGetUserDetails(term: String) {
        let request = Home.UserDetails.Request(term: term)
        interactor?.doGetUserDetails(request: request)
    }

    func displayUserDetails(viewModel: Home.UserDetails.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else {
            // Navigate to UserDetails
            return
        }
        // Display error
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
