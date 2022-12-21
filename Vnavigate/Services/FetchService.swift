//
//  FetchService.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import Foundation

enum FetchResult {
    case success([AuthorsSections])
    case failure(Error)
}

enum FetchError {
    case fileNotFound
    case decodeError
    case unownedError
}

final class FetchService {

    static let shared = FetchService()

    private init() {}

    func fetchAuthorSection(completion: @escaping (FetchResult) -> Void) {
        do {
            guard let bundlePath = Bundle.main.path(forResource: "model", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else {
                completion(.failure(FetchError.fileNotFound))
                return
            }

            guard let dacodetedData = try? JSONDecoder().decode([AuthorsSections].self, from: jsonData) else {
                completion(.failure(FetchError.decodeError))
                return
            }

            completion(.success(dacodetedData))

        } catch {
            completion(.failure(FetchError.unownedError))
        }
    }
}

extension FetchError: LocalizedError {
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
