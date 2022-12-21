//
//  ConfirmLoginViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

class ConfirmLoginViewController: UIViewController {
    
    private let coordinator: AuthCoordinator

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение входа"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = CustomColor.orange
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили SMS с кодом на номер"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+38 099 999 99 99"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из SMS"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = CustomColor.gray
        return label
    }()

    private lazy var smsField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.placeholder = "* * * * * *"
        field.borderStyle = .roundedRect
        field.textAlignment = .center
        //        field.delegate = self
        field.keyboardType = .numberPad
        return field
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = CustomColor.accent
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()

    private let bannerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "auth_check")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setSubviews(subviews: titleLabel, infoLabel, phoneNumberLabel, instructionLabel, smsField, loginButton, bannerImage)
        setConstraints()
    }

    private func setSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            phoneNumberLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            instructionLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 100),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            smsField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            smsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            smsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            smsField.heightAnchor.constraint(equalToConstant: 50),

            loginButton.topAnchor.constraint(equalTo: smsField.bottomAnchor, constant: 70),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            bannerImage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50),
            bannerImage.widthAnchor.constraint(equalToConstant: 86),
            bannerImage.heightAnchor.constraint(equalToConstant: 100),
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc
    private func didTapLoginButton() {

    }
}
