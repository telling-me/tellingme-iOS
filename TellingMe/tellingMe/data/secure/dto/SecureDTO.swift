//
//  SecureDTO.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 11/1/23.
//

import Foundation

/**
 비밀번호를 잃어버렸을 때, 팝업창에서 이메일을 보여주기 위한 Response 모델입니다.
 */
struct SecureFetchEmailResponse: Codable {
    let email: String
}

/**
 비밀번호를 잃어버렸을 때, 새로운 비밀번호를 받기 위한 검증용 이메일 Request 모델입니다.
 */
struct SecurePostEmailRequest: Codable {
    let email: String
}

/**
 비밀번호를 잃어버렸을 때, 비밀번호를 초기화하고 이메일을 보내는 Request 모델입니다.
 */
struct SecurePostNewSecureValueRequest: Codable {
    let password: Int
}
