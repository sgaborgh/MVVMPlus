//
//  ApiManager.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation
import OSLog


// MARK: network interface

protocol NetworkRequestManager {

    func request<T: Codable>(url: URL) async throws -> T
    // func uploadRequest(...)
    // func downloadFiles(...)
    // func uploadFiles(...)

}


// MARK: singleton implementation

final class ApiManager: NetworkRequestManager {


    // MARK: error related

    enum ApiError: Error {

        case invalidHTTPResponse
        case invalidResponseCode(Int?)
        case cannotDecodeObjectFromData

    }


    // MARK: properties

    static let shared: ApiManager = .init()

    private let logger: Logger
    private let urlSession: URLSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = .init()


    // MARK: life-cycle

    private init() {
        logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ApiManager")
        jsonDecoder.dateDecodingStrategy = .iso8601 // irrelevant for the demo
    }


    // MARK: public methods

    func request<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            logger.warning("Invalid response received from URL: \(url.absoluteString)")
            throw ApiError.invalidHTTPResponse
        }

        guard response.statusCode == 200 else {
            logger.warning("Invalid status code (\(response.statusCode)) received from URL: \(url.absoluteString)")
            throw ApiError.invalidResponseCode(response.statusCode)
        }

        let decodedObject: T
        do {
            decodedObject = try jsonDecoder.decode(T.self, from: data)
        } catch (let error) {
            logger.error("Cannot decode reveived JSON data. \(error.localizedDescription)")
            throw ApiError.cannotDecodeObjectFromData
        }

        return decodedObject
    }

}
