//
//  ProfilePhotoCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import UIKit

class ProfilePhotoCell: UICollectionViewCell {

    private lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    var viewModel: ProfilePhotoCellViewModel? {
        didSet {
            photoImage.image = UIImage(named: viewModel?.photoImage ?? "noimage")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        setSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubviews() {
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoImage)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoImage.widthAnchor.constraint(equalToConstant: 70),
            photoImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
