//
//  String + Extension.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 14.12.2022.
//

extension String {
    func limitedText(to symbols: Int) -> String {
        guard self.count > symbols else {
            return self
        }
        return self.prefix(symbols) + " ..."
    }
}
