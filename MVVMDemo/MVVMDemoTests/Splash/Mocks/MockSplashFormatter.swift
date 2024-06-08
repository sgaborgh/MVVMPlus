//
//  MockSplashFormatter.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit
@testable import MVVMDemo

final class MockSplashFormatter: SplashFormatterProtocol {
    
    var isUIModelCreationCalled: Bool = false

    func createUIModel(withText text: String) -> MVVMDemo.SplashUIModel {
        isUIModelCreationCalled = true
        return .init(welcomeLabelText: "")
    }

}
