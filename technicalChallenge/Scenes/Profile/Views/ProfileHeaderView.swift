//
//  ProfileHeaderView.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

struct ProfileHeaderViewData {
    let name: String
    let avatar: String?
}

class ProfileHeaderView: UIView {

    // MARK: - Constants

    private struct ViewTraits {
        // Margins
        static let contentMargin: CGFloat = 20.0
        static let contentSpacing: CGFloat = 18.0
        // Sizes
        static let imageSize: CGFloat = 150.0
    }

    // MARK: - Properties

    private let contentView = UIStackView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()

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

    func setupUI(data: ProfileHeaderViewData) {
        nameLabel.text = data.name
        if let avatar = data.avatar,
           let url = URL(string: avatar) {
                imageView.load(url: url)
        }
    }

    private func setupComponents() {
        backgroundColor = .systemGray6
        accessibilityIdentifier = "profileHeaderView"

        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.distribution = .fill
        contentView.spacing = ViewTraits.contentSpacing

        nameLabel.text = "John Doe"

        imageView.image = UIImage(named: "profile_icon")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = ViewTraits.imageSize / 2
        imageView.layer.borderColor = .none

        contentView.addArrangedSubview(imageView)
        contentView.addArrangedSubview(nameLabel)

        addSubviewForAutolayout(contentView)
    }

    private func setupConstraints() {
      NSLayoutConstraint.activate([
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
        contentView.topAnchor.constraint(equalTo: topAnchor,
                                         constant: ViewTraits.contentMargin),
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: ViewTraits.contentMargin),
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                              constant: -ViewTraits.contentMargin),
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: -ViewTraits.contentMargin),

        imageView.heightAnchor.constraint(equalToConstant: ViewTraits.imageSize),
        imageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageSize)
      ])
    }
}
