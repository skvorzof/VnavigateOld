//
//  ProfileSettingsViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 26.12.2022.
//

import UIKit
import FirebaseAuth

class ProfileSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        do {
            try Auth.auth().signOut()
        } catch {}
    }
}
