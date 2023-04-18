//
//  TestDataSource.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Alamofire
import Combine

enum SignAPI {
    typealias Request = OauthRequest
    typealias Response = OauthResponse
    
    static let networkProvider = NetworkProvider()
    static let apiURL = Bundle.main.APIURL
    
    static func request(loginType: String, parameter: Request) -> AnyPublisher<Response, APIError> {
        let urlComponents = URLComponents(string: apiURL + "/api/oauth/\(loginType)")!
        let request = AF.request(urlComponents.url!, method: .post, parameters: parameter)
    
        return networkProvider.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
