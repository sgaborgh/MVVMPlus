//
//  String+Localized.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }

}
