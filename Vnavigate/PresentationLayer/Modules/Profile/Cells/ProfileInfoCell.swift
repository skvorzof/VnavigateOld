//
//  ProfileInfoCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

protocol ProfileInfoCellDelegateProtocol: AnyObject {
    func didTapPhotosButton()
    func didTapsettingsButton()
}

class ProfileInfoCell: UICollectionViewCell {

    weak var delegate: ProfileInfoCellDelegateProtocol?

    private let avatarImage = CircularImageView()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColor.gray
        return label
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = CustomColor.orange
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        button.addTarget(self, action: #selector(didTapsettingsButton), for: .touchUpInside)
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = CustomColor.orange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return button
    }()

    private let publicationsLabel: UILabel = {
        let label = UILabel()
        label.text = "1400\n публикаций"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followLabel: UILabel = {
        let label = UILabel()
        label.text = "447\n подписок"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "161 тыс.\n подписчиков"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationsLabel, followLabel, followersLabel])
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    private lazy var photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postButton, historyButton, photoButton])
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()

    private let headerPhotosLabel: UILabel = {
        let label = UILabel()
        label.text = "Фотографии"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private let countPhotosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = CustomColor.gray
        label.text = "15"
        return label
    }()

    private lazy var photosButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(didTapPhotosButton), for: .touchUpInside)
        return button
    }()

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

        setSubviews(
            avatarImage, authorLabel, professionLabel, settingsButton, editButton, infoStackView, buttonsStackView, headerPhotosLabel,
            countPhotosLabel,
            photosButton)
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

            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 16),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            editButton.heightAnchor.constraint(equalToConstant: 50),
            editButton.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            infoStackView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            buttonsStackView.heightAnchor.constraint(equalToConstant: 30),
            buttonsStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            headerPhotosLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 40),
            headerPhotosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            countPhotosLabel.topAnchor.constraint(equalTo: headerPhotosLabel.topAnchor),
            countPhotosLabel.leadingAnchor.constraint(equalTo: headerPhotosLabel.trailingAnchor, constant: 10),

            photosButton.widthAnchor.constraint(equalToConstant: 30),
            photosButton.topAnchor.constraint(equalTo: countPhotosLabel.topAnchor, constant: 0),
            photosButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    @objc private func didTapsettingsButton() {
        delegate?.didTapsettingsButton()
    }

    @objc private func didTapEditButton() {
        delegate?.didTapsettingsButton()
    }

    @objc private func didTapPhotosButton() {
        delegate?.didTapPhotosButton()
    }
}
