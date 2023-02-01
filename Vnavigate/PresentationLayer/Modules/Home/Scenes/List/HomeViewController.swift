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
    private var dataSource: HomeLisDiffableDataSource?

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        return activityIndicator
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: HomeCompositionalLayout { [weak self] in
                self?.viewModel.dataSourceSnapshot.sectionIdentifiers[$0].layoutType ?? .friendsLayout
            })
        return collectionView
    }()

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
        configureVewModel()
        viewModel.changeState(.initial)
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
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(cellType: HomeFriendCell.self)
        collectionView.register(cellType: HomePostCell.self)
        collectionView.delegate = self

        view.addSubview(collectionView)

        dataSource = HomeLisDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .friendsItem(let viewModelCell):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeFriendCell.self)
                cell.viewModel = viewModelCell
                return cell
            case .postsItem(let viewModelCell):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomePostCell.self)
                cell.viewModel = viewModelCell
                return cell
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = dataSource?.itemIdentifier(for: indexPath) else { return }
        switch section {
        case .friendsItem(let author):
            let author = Author(name: author.author, profession: "", isFriend: false, avatar: "", photos: [], posts: [])
            coordinator.coordinateToHomeAuthorProfile(author: author)
            
        case .postsItem(let post):
            let post = Post(thumbnail: post.thumbnail, article: post.article, isLike: post.isLike, like: post.like, isFavorites: post.isFavorites)
            coordinator.coordinateToHomePostDetail(post: post)
        }
    }
}
