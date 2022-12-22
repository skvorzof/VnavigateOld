//
//  ProfileViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 14.12.2022.
//

import UIKit



class ProfileViewController: UIViewController {
    

    private let coordinator: ProfileCoordinator
    private let viewModel: ProfileViewModel
    private var dataSource: AuthorDetailDiffableDataSource?

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        return activityIndicator
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        return collectionView
    }()

    init(coordinator: ProfileCoordinator, viewModel: ProfileViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureColletionView()
        configureVewModel()
        viewModel.changeState(.initial)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - configureVewModel
    private func configureVewModel() {
        viewModel.updateState = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .initial:
                break
            case .loading:
                self.activityIndicator.startAnimating()
            case .loaded:
                self.activityIndicator.stopAnimating()
                self.dataSource?.apply(self.viewModel.dataSourceSnapshot)
            case .error(let error):
                self.showAlert(with: "Ошибка", and: error)
            }
        }

    }

    // MARK: - configureColletionView
    private func configureColletionView() {
        let profileInfoCellRegistration = UICollectionView.CellRegistration<ProfileInfoCell, Author> { cell, indexPath, model in
            cell.setupCell(with: model)
        }

        let postCellRegistration = UICollectionView.CellRegistration<PostCell, Author> { cell, indexPath, model in
            cell.setupCell(with: model)
        }

        dataSource = AuthorDetailDiffableDataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, model -> UICollectionViewCell in

            switch ProfileSection(rawValue: indexPath.section) {
            case .info:
                return collectionView.dequeueConfiguredReusableCell(using: profileInfoCellRegistration, for: indexPath, item: model)
            case .photos:
                return collectionView.dequeueConfiguredReusableCell(using: profileInfoCellRegistration, for: indexPath, item: model)
            case .posts:
                return collectionView.dequeueConfiguredReusableCell(using: postCellRegistration, for: indexPath, item: model)
            case .none:
                return UICollectionViewCell()
            }
        }
    }
}

// MARK: - createCompositionalLayout
extension ProfileViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in

            let section = ProfileSection(rawValue: sectionIndex)
            switch section {
            case .info:
                return LayoutManager.shared.createProfileSection()
            case .photos:
                return LayoutManager.shared.createFriendSection()
            case .posts:
                return LayoutManager.shared.createPostSection()
            case .none:
                return LayoutManager.shared.createPostSection()
            }
        }
        return layout
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let author = dataSource?.itemIdentifier(for: indexPath) else { return }
//        switch viewModel.authorsSections[indexPath.section].type {
//        case "friends":
//            break
//        default:
//            break
//        }
    }
}
