//
//  ProfilePhotoCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import UIKit

class ProfilePhotoCell: UICollectionViewCell {

    private let photoImage = UIImageView()

    var viewModel: ProfilePhotoCellViewModel? {
        didSet {
            photoImage.image = UIImage(named: viewModel?.photoImage ?? "plus")
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
            photoImage.widthAnchor.constraint(equalToConstant: 60),
            photoImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
