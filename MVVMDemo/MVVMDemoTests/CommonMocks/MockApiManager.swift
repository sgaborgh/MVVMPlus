//
//  MockApiManager.swift
//  MVVMDemoTests
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation
@testable import MVVMDemo

final class MockApiManager: NetworkRequestManager {

    var isRequestMethodCalled: Bool = false

    func request<T: Codable>(url: URL) async throws -> T {
        isRequestMethodCalled = true

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

}
