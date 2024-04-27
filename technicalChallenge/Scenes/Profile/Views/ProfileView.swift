//
//  ProfileView.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

enum ProfileViewState {
    case loading
    case loaded(headerViewData: ProfileHeaderViewData)
}

class ProfileView: UIView {

    // MARK: - Constants

    private struct ViewTraits {
        // Margins
        static let contentTopMargin: CGFloat = 50.0
        static let contentMargin: CGFloat = 40.0
        static let contentSpacing: CGFloat = 18.0
        // Sizes
        static let imageSize: CGFloat = 200.0
        static let loaderSize: CGFloat = 50.0
    }

    // MARK: - Properties
    private let profileHeaderView = ProfileHeaderView()
    private let loaderView = LoaderView()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setState(state: ProfileViewState) {
        switch state {
        case .loading:
            profileHeaderView.isHidden = true
            loaderView.isHidden = false
            loaderView.startAnimating()
        case .loaded(let headerViewData):
            loaderView.stopAnimating()
            loaderView.isHidden = true
            profileHeaderView.isHidden = false
            profileHeaderView.setupUI(data: headerViewData)
        }
    }

    // MARK: - Private

    private func setupComponents() {
        backgroundColor = .white

        loaderView.isHidden = true

        addSubviewForAutolayout(profileHeaderView)
        addSubviewForAutolayout(loaderView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),

            loaderView.heightAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.widthAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
