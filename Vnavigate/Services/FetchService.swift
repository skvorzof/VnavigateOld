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

final class FetchService {

    static let shared = FetchService()

    private init() {}

    func fetchAuthorsSections(completion: @escaping (FetchResult) -> Void) {
        do {
            guard let bundlePath = Bundle.main.path(forResource: "model", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else {
                completion(.failure(CustomError.fileNotFound))
                return
            }

            guard let dacodetedData = try? JSONDecoder().decode([AuthorsSections].self, from: jsonData) else {
                completion(.failure(CustomError.decodeError))
                return
            }

            completion(.success(dacodetedData))

        } catch {
            completion(.failure(CustomError.unownedError))
        }
    }
}
