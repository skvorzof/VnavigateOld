//
//  FetchService.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import Foundation

enum FetchResult<T> {
    case success([T])
    case failure(Error)
}

final class FetchService {

    static let shared = FetchService()

    private init() {}

    func fetchSection<T: Decodable>(modelType: T.Type, fileName: String, completion: @escaping (FetchResult<T>) -> Void) {
        do {
            guard let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else {
                completion(.failure(CustomError.fileNotFound))
                return
            }

            guard let dacodetedData = try? JSONDecoder().decode([T].self, from: jsonData) else {
                completion(.failure(CustomError.decodeError))
                return
            }

            completion(.success(dacodetedData))
        } catch {
            completion(.failure(CustomError.unownedError))
        }
    }
}
