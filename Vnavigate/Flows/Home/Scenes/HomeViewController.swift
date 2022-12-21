//
//  HomeViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 13.12.2022.
//

import UIKit

class HomeViewController: UIViewController {

    let sections = Bundle.main.decode([Section].self, from: "model.json")

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Author>
    var dataSource: DataSource?

    private let coordinator: HomeCoordinator

    private var collectionView: UICollectionView!

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureCollectionView()
        reloadData()
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        let friendCellRegistration = UICollectionView.CellRegistration<FriendCell, Author> { cell, indexPath, model in
            cell.setupCell(with: model)
        }

        let postCellRegistration = UICollectionView.CellRegistration<PostCell, Author> { cell, indexPath, model in
            cell.setupCell(with: model)
        }

        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, model -> UICollectionViewCell? in

                switch self?.sections[indexPath.section].type {
                case "friends":
                    return collectionView.dequeueConfiguredReusableCell(using: friendCellRegistration, for: indexPath, item: model)
                default:
                    return collectionView.dequeueConfiguredReusableCell(using: postCellRegistration, for: indexPath, item: model)
                }
            })
    }

    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Author>()
        snapshot.appendSections(sections)

        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource?.apply(snapshot)
    }

    private func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex].type

            switch section {
            case "friends":
                return self.createFriendSection()
            default:
                return self.createPostSection()
            }
        }
        return layout
    }

    private func createFriendSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .estimated(60), heightDimension: .estimated(60)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return section
    }

    private func createPostSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(410)))
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 50, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
