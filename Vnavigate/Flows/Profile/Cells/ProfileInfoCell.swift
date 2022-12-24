//
//  ProfileInfoCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

class ProfileInfoCell: UICollectionViewCell {

    private let avatarImage = CircularImageView()
    private let authorLabel = UILabel()
    private let professionLabel = UILabel()

    var viewModel: ProfileInfoCellViewModel? {
        didSet {
            avatarImage.image = UIImage(named: viewModel?.avatarImage ?? "plus")
            authorLabel.text = viewModel?.authorLabel
            professionLabel.text = viewModel?.professionLabel
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        setSubviews(avatarImage, authorLabel, professionLabel)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.topAnchor.constraint(equalTo: topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),

            authorLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 7),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),

            professionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            professionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
        ])
    }
}
