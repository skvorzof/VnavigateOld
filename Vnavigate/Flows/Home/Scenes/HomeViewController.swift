//
//  HomeViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 13.12.2022.
//

import UIKit

class HomeViewController: UIViewController {

    private let coordinator: HomeCoordinator
    private let viewModel: HomeViewModel

    private var dataSource: AuthorsLisDiffableDataSource!

    private var collectionView: UICollectionView!

    init(coordinator: HomeCoordinator, viewModel: HomeViewModel) {
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
        viewModel.loadData()
        dataSource.apply(viewModel.dataSourceSnapshot)

        viewModel.showError = { [weak self] message in
            self?.showAlert(with: "Ошибка", and: message)
        }
    }

    private func configureColletionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self

        let friendCellRegistration = UICollectionView.CellRegistration<FriendCell, Author> { cell, indexPath, model in
            cell.setupCell(with: model)
        }

        let postCellRegistration = UICollectionView.CellRegistration<PostCell, Author> { cell, indexPath, model in
            cell.setupCell(with: model)
        }

        dataSource = AuthorsLisDiffableDataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, model -> UICollectionViewCell in

            switch self.viewModel.authorsSections[indexPath.section].type {
            case "friends":
                return collectionView.dequeueConfiguredReusableCell(using: friendCellRegistration, for: indexPath, item: model)
            default:
                return collectionView.dequeueConfiguredReusableCell(using: postCellRegistration, for: indexPath, item: model)
            }
        }
    }
}

extension HomeViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let section = self?.viewModel.authorsSections[sectionIndex].type

            switch section {
            case "friends":
                return LayoutManager.shared.createFriendSection()
            default:
                return LayoutManager.shared.createPostSection()
            }
        }
        return layout
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let author = dataSource.itemIdentifier(for: indexPath) else { return }
        switch viewModel.authorsSections[indexPath.section].type {
        case "friends":
            coordinator.coordinateToHomeAuthorProfile(author: author)
        default:
            coordinator.coordinateToHomePostDetail(author: author)
        }
    }
}
