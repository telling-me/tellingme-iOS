//
//  RxSwift+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/22.
//

import Foundation

import RxSwift

extension ObservableType {
    /**
     특정 시간을 주기로, 재시도를 할 수 있다.
     */
    func retry(maxAttempts: Int, delay: Int) -> Observable<Element> {
        return self.retry(when: { errors in
            return errors.enumerated().flatMap { (index, error) -> Observable<Int64> in
                if index <= maxAttempts {
                    return Observable<Int64>.timer(.seconds(delay), scheduler: MainScheduler.instance)
                } else {
                    return Observable.error(error)
                }
            }
        })
    }
}
