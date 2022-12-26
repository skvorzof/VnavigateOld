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
    private var dataSource: ProfileDiffableDataSource?

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        return activityIndicator
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: ProfileCompositionalLayout { [weak self] in
                self?.viewModel.dataSourceSnapshot.sectionIdentifiers[$0].layoutType ?? .infoLayout
            })
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
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(cellType: ProfileInfoCell.self)
        collectionView.register(cellType: ProfilePhotoCell.self)
        collectionView.register(cellType: ProfilePostCell.self)
        collectionView.delegate = self
        view.addSubview(collectionView)

        dataSource = ProfileDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .infoItem(let viewModelCell):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProfileInfoCell.self)
                cell.viewModel = viewModelCell
                cell.contentView.isUserInteractionEnabled = false
                cell.delegate = self
                return cell

            case .photosItem(let viewModelCell):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProfilePhotoCell.self)
                cell.viewModel = viewModelCell
                return cell

            case .postsItem(let viewModelCell):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProfilePostCell.self)
                cell.viewModel = viewModelCell
                return cell
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let profile = dataSource?.itemIdentifier(for: indexPath) else { return }

        switch profile {
        case .infoItem:
            break

        case .photosItem:
            coordinator.coordinateToProfilePhotos()

        case .postsItem:
            break
        }
    }
}

// MARK: - ProfileInfoCellDelegateProtocol
extension ProfileViewController: ProfileInfoCellDelegateProtocol {
    func didTapsettingsButton() {
        coordinator.coordinateToProfileSettings()
    }

    func didTapPhotosButton() {
        coordinator.coordinateToProfilePhotos()
    }
}
