//
//  SplashFormatter.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation


// MARK: interface

protocol SplashFormatterProtocol {
    
    func createUIModel(withText text: String) -> SplashUIModel

}


// MARK: formatter

final class SplashFormatter: SplashFormatterProtocol {

    func createUIModel(withText text: String) -> SplashUIModel {
        .init(welcomeLabelText: text)
    }

}
