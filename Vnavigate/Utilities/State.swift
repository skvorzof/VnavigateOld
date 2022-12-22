//
//  State.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import Foundation

enum State {
    case initial
    case loading
    case loaded
    case error(String)
}

enum Action {
    case initial
}
