//
//  Car.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation

struct Car: Codable, Equatable {

    let brand: String // now it also acts as a unique Id of the car, but in reality it's a separate data
    let models: [String]

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.brand == rhs.brand
    }

}
