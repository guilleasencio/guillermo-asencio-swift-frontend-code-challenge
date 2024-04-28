//
//  BackBarButtonItem.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import UIKit

protocol BackBarButtonItemDelegate: AnyObject {
    func backBarButtonItemDidPress(_ button: BackBarButtonItem)
}

class BackBarButtonItem: UIView {

    // MARK: - Constants

    private struct ViewTraits {
        // Sizes
        static let buttonSize: CGFloat = 32.0
    }

    // MARK: - Properties

    weak var delegate: BackBarButtonItemDelegate?

    private let barButtonView = UIButton()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc private func didTapBackButton() {
        delegate?.backBarButtonItemDidPress(self)
    }

    // MARK: - Private

    private func setupComponents() {
        barButtonView.setImage(UIImage(named: "back_arrow"), for: .normal)
        barButtonView.imageView?.contentMode = .scaleAspectFit
        barButtonView.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        addSubviewForAutolayout(barButtonView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            barButtonView.heightAnchor.constraint(equalToConstant: ViewTraits.buttonSize),
            barButtonView.widthAnchor.constraint(equalToConstant: ViewTraits.buttonSize),
            barButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barButtonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barButtonView.topAnchor.constraint(equalTo: topAnchor),
            barButtonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
