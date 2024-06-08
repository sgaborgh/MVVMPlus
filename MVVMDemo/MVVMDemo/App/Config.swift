//
//  Config.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation

struct Config {

    struct Api {

        // in reality the server url's and data could be handled with OpenAPI's generated network API,
        // or in case of a GraphQL server: generated with ApolloCodegen
        static let carListUrlString: String = "https://raw.githubusercontent.com/matthlavacka/car-list/master/car-list.json"

    }

    struct SplashScreen {

        static let logoFileName: String = "logo"
        static let possibleWelcomeTextList: [String] = [
            "Welcome!".localized,
            "Greetings!".localized,
            "Have a nice day!".localized
        ]
        static let visibleForSeconds: TimeInterval = 5.0
        static let fadeDuration: TimeInterval = 1 // happens two times: in & out fade
        static let fadeOutDelay: TimeInterval = 3

    }

}
