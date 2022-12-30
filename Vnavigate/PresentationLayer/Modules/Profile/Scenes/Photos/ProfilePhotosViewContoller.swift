//
//  ProfilePhotosViewContoller.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 26.12.2022.
//

import UIKit

class ProfilePhotosViewContoller: UIViewController {

    private let coordinator: ProfileCoordinator
    private let viewModel: ProfilePhotosViewModel

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    init(coordinator: ProfileCoordinator, viewModel: ProfilePhotosViewModel) {
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
    }

    private func configureColletionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(cellType: ProfilePhotoCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
            layout.itemSize = CGSize(width: 70, height: 70)
            layout.minimumLineSpacing = 2
            layout.minimumInteritemSpacing = 2
            layout.scrollDirection = .vertical
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ProfilePhotosViewContoller: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProfilePhotoCell.self)
        let photo = viewModel.photos[indexPath.item]
        cell.viewModel = ProfilePhotoCellViewModel(photo: photo)
        return cell
    }
}

extension ProfilePhotosViewContoller: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.item]
        coordinator.coordinateToPhotosDetails(photo: photo)
    }
}
