//
//  CustomError.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import Foundation

enum CustomError {
    case fileNotFound
    case decodeError
    case unownedError
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return NSLocalizedString("Json файл не найден", comment: "")
        case .decodeError:
            return NSLocalizedString("Ошибка декодирования", comment: "")
        case .unownedError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}
