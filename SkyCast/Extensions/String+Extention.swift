//
//  String+Extention.swift
//  SkyCast
//
//  Created by Василий Тихонов on 19.07.2024.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main,
                          value: self,
                          comment: self)
    }
}
