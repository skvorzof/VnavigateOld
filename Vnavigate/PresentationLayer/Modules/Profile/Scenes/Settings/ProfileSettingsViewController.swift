//
//  ProfileSettingsViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 26.12.2022.
//

import FirebaseAuth
import UIKit

class ProfileSettingsViewController: UIViewController {

    private let coordinator: ProfileCoordinator

    private lazy var xmarkButton = UIBarButtonItem(
        image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapXmarkButton))

    private lazy var checkmarkButton = UIBarButtonItem(
        image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(didTapCheckmarkButton))

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя фамилия"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.placeholder = "Имя фамилия"
        field.borderStyle = .roundedRect
        return field
    }()

    private let dateBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата рождения"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var dateBirthField: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.layer.borderWidth = 1
        datePicker.layer.cornerRadius = 10
        return datePicker
    }()

    private let sityLabel: UILabel = {
        let label = UILabel()
        label.text = "Город"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var sityField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.placeholder = "Город"
        field.borderStyle = .roundedRect
        return field
    }()

    private lazy var outButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapOutButton), for: .touchUpInside)
        return button
    }()

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setSubviews(subviews: nameLabel, nameField, dateBirthLabel, dateBirthField, sityLabel, sityField, outButton)
        setConstraints()
    }

    private func setSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    private func setUI() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = xmarkButton
        navigationItem.rightBarButtonItem = checkmarkButton
    }

    @objc
    private func didTapXmarkButton() {
        coordinator.coordinateToRoot()
    }

    @objc
    private func didTapCheckmarkButton() {
        coordinator.coordinateToRoot()
    }

    @objc
    private func didTapOutButton() {
        do {
            try Auth.auth().signOut()
            coordinator.coordinateToRoot()
        } catch {}
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            dateBirthLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            dateBirthLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateBirthLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            dateBirthField.topAnchor.constraint(equalTo: dateBirthLabel.bottomAnchor, constant: 8),
            dateBirthField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateBirthField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            sityLabel.topAnchor.constraint(equalTo: dateBirthField.bottomAnchor, constant: 20),
            sityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sityLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            sityField.topAnchor.constraint(equalTo: sityLabel.bottomAnchor, constant: 8),
            sityField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sityField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            outButton.topAnchor.constraint(equalTo: sityField.bottomAnchor, constant: 40),
            outButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outButton.widthAnchor.constraint(equalToConstant: 200),
            outButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
