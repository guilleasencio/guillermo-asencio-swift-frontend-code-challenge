//
//  ProfileViewController.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displayData(viewModel: Profile.Data.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?

    private let sceneView = ProfileView()

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
        setupNavigationBar()
        loadData()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationItem.title = "User's Repositories"
        navigationController?.setNavigationBarHidden(false, animated: false)
        let backButtonView = BackBarButtonItem()
        backButtonView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButtonView)
    }

    // MARK: - Output

    func loadData() {
        sceneView.setState(state: .loading)
        let request = Profile.Data.Request()
        interactor?.loadData(request: request)
    }

    // MARK: - Input

    func displayData(viewModel: Profile.Data.ViewModel) {
        switch viewModel.viewState {
        case .success(let headerViewData, let cellData):
            sceneView.setState(state: .loaded(headerViewData: headerViewData, cellData: cellData))
        case .error(let message):
            router?.routeToAlert(message: message)
        }
    }
}

// MARK: - BackBarButtonItemDelegate

extension ProfileViewController: BackBarButtonItemDelegate {
    func backBarButtonItemDidPress(_ button: BackBarButtonItem) {
        router?.routeToBack()
    }
}
