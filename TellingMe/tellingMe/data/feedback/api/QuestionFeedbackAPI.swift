//
//  FeedbackAPI.swift
//  tellingMe
//
//  Created by 마경미 on 24.09.23.
//

import Foundation

import Moya
import RxMoya
import RxSwift

enum QuestionFeedbackAPITarget {
    case postQuestionFeedback(QuestionFeedbackRequest)
}

extension QuestionFeedbackAPITarget: TargetType {
    var path: String {
        switch self {
        case .postQuestionFeedback:
            return "api/feedback"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postQuestionFeedback:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postQuestionFeedback(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
     }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}

struct QuestionFeedbackAPI: Networkable {
    typealias Target = QuestionFeedbackAPITarget

    static func postQuestionFeedback(request: QuestionFeedbackRequest) -> Observable<QuestionFeedbackResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .postQuestionFeedback(request))
        } catch  {
            print("Error getting Authroized Provider.")
            return Observable.error(APIError.tokenNotFound)
        }
    }
}
