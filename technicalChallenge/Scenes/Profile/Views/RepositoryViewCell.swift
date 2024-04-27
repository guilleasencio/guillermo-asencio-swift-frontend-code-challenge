//
//  RepositoryViewCell.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

struct RepositoryViewCellData {
    let name: String
    let language: String?
}

class RepositoryViewCell: UITableViewCell {

    // MARK: - Constants

    private struct ViewTraits {
        // Margins
        static let contentMargin: CGFloat = 18.0
        static let languageTopMargin: CGFloat = 8
        // Fonts
        static let fontSize: CGFloat = 13.0
    }

    // MARK: - Properties

    private let nameLabel = UILabel()
    private let languageLabel = UILabel()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setupUI(data: RepositoryViewCellData) {
        nameLabel.text = data.name
        languageLabel.text = data.language != nil ? data.language : ""
    }

    private func setupComponents() {
        backgroundColor = .white

        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: ViewTraits.fontSize)
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black

        languageLabel.lineBreakMode = .byWordWrapping
        languageLabel.numberOfLines = 0
        languageLabel.font = UIFont.systemFont(ofSize: ViewTraits.fontSize)
        languageLabel.textAlignment = .left
        languageLabel.textColor = .black

        contentView.addSubviewForAutolayout(nameLabel)
        contentView.addSubviewForAutolayout(languageLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: ViewTraits.contentMargin),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: ViewTraits.contentMargin),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -ViewTraits.contentMargin),

            languageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                               constant: ViewTraits.languageTopMargin),
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: ViewTraits.contentMargin),
            languageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -ViewTraits.contentMargin),
            languageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -ViewTraits.contentMargin)
        ])
    }
}
