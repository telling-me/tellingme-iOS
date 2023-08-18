//
//  CommunicationDetail.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import Foundation

//{"content":[{"answerId":320,"content":"마라 엽떡이 재고 소진이라 8월에나 먹을 수 있대료 !!!! 이씨 !!!!!!!!","createdTime":[2023,7,29,17,17,40,662353000],"userId":"4c75a21a-75c3-427c-a190-efae421c1cbc","likeCount":0,"job":1,"purpose":"[2,3]","weight":0},{"answerId":319,"content":"안녕 나는 모기를 잘 잡는 애플 키태야","createdTime":[2023,7,29,17,16,46,753227000],"userId":"8e598f61-0c8d-48e7-af8a-f94887207c03","likeCount":2,"job":4,"purpose":"[0,1]","weight":0},{"answerId":318,"content":"테스트 계정은 아니지만 성오언니의 계정을 약탈했다 !!!!","createdTime":[2023,7,29,17,15,42,736364000],"userId":"d8cd7a95-8984-4c89-8480-51236b6f0e59","likeCount":2,"job":3,"purpose":"[1,3]","weight":0},{"answerId":317,"content":"1박 2일로다가 에버랜드랑 캐리비안베이 가고 싶다 ㅠㅠ...","createdTime":[2023,7,29,17,14,20,71355000],"userId":"1dbf201f-ff7f-4eca-ade1-280f88fa379f","likeCount":3,"job":1,"purpose":"[2]","weight":0},{"answerId":316,"content":"오늘 집가서 미션 임ㅍㅏ서블 봐야징 ~~~~","createdTime":[2023,7,29,17,13,15,69425000],"userId":"03b81066-3e6d-4528-bd14-88cab694f464","likeCount":4,"job":2,"purpose":"[1]","weight":0},{"answerId":315,"content":"에어컨 트니까 너무 춥다 흑흑","createdTime":[2023,7,29,17,12,26,343125000],"userId":"38f728d0-4414-453e-8222-251e1817c6a6","likeCount":1,"job":0,"purpose":"[3]","weight":0},{"answerId":314,"content":"소통 공간이 드디어 끝나가용 ~!!~!","createdTime":[2023,7,29,17,11,19,760198000],"userId":"786da0f9-fcc8-4242-8b6c-fd12f0b8a2ff","likeCount":1,"job":1,"purpose":"[1]","weight":0}],"pageable":{"sort":{"empty":true,"sorted":false,"unsorted":true},"offset":0,"pageNumber":0,"pageSize":10,"paged":true,"unpaged":false},"last":true,"totalPages":1,"totalElements":7,"size":10,"number":0,"sort":{"empty":true,"sorted":false,"unsorted":true},"first":true,"numberOfElements":7,"empty":false}

struct Content: Codable {
    let answerId: Int
    let content: String
    let createdTime: [Int]
    let userId: String
    var likeCount: Int
    let job: Int
    let purpose: String
    let weight: Int
    let emotion: Int
    var isLiked: Bool
}

extension Content {
    static var defaultContent: Content {
        return Content(answerId: 0, content: "", createdTime: [], userId: "", likeCount: 0, job: 0, purpose: "", weight: 0, emotion: 1, isLiked: false)
    }
}

struct Sort: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}

struct Pageable: Codable {
    let sort: Sort
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let paged: Bool
    let unpaged: Bool
}

struct CommunicationListResponse: Codable {
    let content: [Content]
    let pageable: Pageable
    let totalPages: Int
    let totalElements: Int
    let last: Bool
    let size: Int
    let number: Int
    let sort: Sort
    let first: Bool
    let numberOfElements: Int
    let empty: Bool
}
