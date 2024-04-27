//
//  ProfileViewController.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displaySomething(viewModel: Profile.Something.ViewModel)
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
        doSomething()
    }

    // MARK: Do something

    func doSomething() {
        let request = Profile.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: Profile.Something.ViewModel) {
    }
}
