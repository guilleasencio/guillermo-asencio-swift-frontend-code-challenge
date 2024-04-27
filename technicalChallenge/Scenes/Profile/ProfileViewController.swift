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

    override func loadView() {
        view = sceneView
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Output

    func loadData() {
        sceneView.setState(state: .loading)
        let request = Profile.Data.Request()
        interactor?.loadData(request: request)
    }

    // MARK: - Input

    func displayData(viewModel: Profile.Data.ViewModel) {
        sceneView.setState(state: .loaded(headerViewData: viewModel.headerViewData,
                                          cellData: viewModel.cellData))
    }
}
