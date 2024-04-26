//
//  HomeView.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapSearchButton(term: String?)
}

class HomeView: UIView {

    // MARK: - Constants

    private struct ViewTraits {
        // Margins
        static let contentTopMargin: CGFloat = 50.0
        static let contentMargin: CGFloat = 40.0
        static let contentSpacing: CGFloat = 18.0
        // Sizes
        static let imageSize: CGFloat = 200.0
        static let loaderSize: CGFloat = 50.0
        static let searchButtontHeight: CGFloat = 40.0
    }

    // MARK: - Properties

    weak var delegate: HomeViewDelegate?

    private let contentView = UIStackView()
    private let imageView = UIImageView()
    private let searchTextField = UITextField(frame: .zero)
    private let searchButton = UIButton()
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

    // MARK: - Actions

    @objc private func didTapSearchButton() {
        delegate?.didTapSearchButton(term: searchTextField.text)
    }

    // MARK: - Private

    private func setupComponents() {
        backgroundColor = .white

        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.distribution = .fill
        contentView.spacing = ViewTraits.contentSpacing

        imageView.image = UIImage(named: "github")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        searchTextField.placeholder = "Username"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .white
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self

        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.title = "Search"
        config.baseForegroundColor = .white
        config.background.backgroundColor = .black

        searchButton.configuration = config
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)

        loaderView.isHidden = true

        contentView.addArrangedSubview(imageView)
        contentView.addArrangedSubview(searchTextField)
        contentView.addArrangedSubview(searchButton)

        addSubviewForAutolayout(contentView)
        addSubviewForAutolayout(loaderView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor,
                                             constant: ViewTraits.contentTopMargin),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: ViewTraits.contentMargin),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -ViewTraits.contentMargin),

            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            searchButton.heightAnchor.constraint(equalToConstant: ViewTraits.searchButtontHeight),

            imageView.heightAnchor.constraint(equalToConstant: ViewTraits.imageSize),
            imageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageSize),

            loaderView.heightAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.widthAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didTapSearchButton(term: textField.text)
        return true
    }
}
