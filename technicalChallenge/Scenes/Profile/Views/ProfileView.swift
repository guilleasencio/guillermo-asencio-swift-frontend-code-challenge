//
//  ProfileView.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

enum ProfileViewState {
    case loading
    case loaded(headerViewData: ProfileHeaderViewData, cellData: [RepositoryViewCellData])
}

class ProfileView: UIView {

    // MARK: - Constants

    private struct ViewTraits {
        // Margins
        static let contentTopMargin: CGFloat = 50.0
        static let contentMargin: CGFloat = 40.0
        static let contentSpacing: CGFloat = 18.0
        // Sizes
        static let loaderSize: CGFloat = 50.0
        static let estimatedHeaderHeight: CGFloat = 200.0
        static let estimatedRowHeight: CGFloat = 50.0
    }

    // MARK: - Properties
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let profileHeaderView = ProfileHeaderView()
    private let loaderView = LoaderView()

    private var tableCellData: [RepositoryViewCellData] = []

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
        case .loaded(let headerViewData, let cellData):
            loaderView.stopAnimating()
            loaderView.isHidden = true
            profileHeaderView.isHidden = false
            profileHeaderView.setupUI(data: headerViewData)
            tableCellData = cellData
            tableView.reloadData()
        }
    }

    // MARK: - Private

    private func setupComponents() {
        backgroundColor = .white

        loaderView.isHidden = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ViewTraits.estimatedRowHeight
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = ViewTraits.estimatedHeaderHeight
        tableView.sectionFooterHeight = 0.0
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.contentInset = .zero
        tableView.register(RepositoryViewCell.self,
                           forCellReuseIdentifier: RepositoryViewCell.reuseIdentifier)
        tableView.accessibilityIdentifier = "repositoriesTableView"

        addSubviewForAutolayout(tableView)
        addSubviewForAutolayout(loaderView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loaderView.heightAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.widthAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return tableCellData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = RepositoryViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        guard let repositoryCell = cell as? RepositoryViewCell else {
            return cell
        }
        repositoryCell.setupUI(data: tableCellData[indexPath.row])
        return repositoryCell
    }
}

// MARK: - UITableViewDelegate

extension ProfileView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      guard section == 0 else {
          return 0
      }
      return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      guard section == 0 else {
          return nil
      }
      return profileHeaderView
  }
}
