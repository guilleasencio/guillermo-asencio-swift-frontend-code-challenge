//
//  ProfileView.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

enum ProfileViewState {
  case loading
  case loaded
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

    func setState(state: HomeViewState) {
        switch state {
        case .loading:
            loaderView.isHidden = false
            loaderView.startAnimating()
        case .loaded:
            loaderView.stopAnimating()
            loaderView.isHidden = true
        }
    }

    // MARK: - Private

    private func setupComponents() {
        backgroundColor = .white

        loaderView.isHidden = false

        addSubviewForAutolayout(loaderView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loaderView.heightAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.widthAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
