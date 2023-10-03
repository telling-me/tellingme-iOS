//
//  SignUpViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

struct Job {
    let title: String
    let imgName: String
}

final class SignUpViewModel {
    private let disposeBag = DisposeBag()
    var currentIndex: Int = 0
    
    lazy var viewControllers: [UIViewController] = {
        return [
            AgreementViewController(viewModel: self),
            NickNameViewController(viewModel: self),
            OptionViewController(viewModel: self),
            JobViewController(viewModel: self),
            PurposeViewController(viewModel: self)
        ]
    }()
    
    let agreementRelays: [BehaviorRelay<Bool>] = [
        BehaviorRelay(value: false),
        BehaviorRelay(value: false),
    ]
    let agreements: [String] = [
        "(필수) 서비스 이용약관 동의",
        "(필수) 개인정보 수집 및 이용 동의"
    ]
    
    let nicknameTextRelay = BehaviorRelay<String>(value: "")
    
    let genderList: Observable<[TeritaryBothData]> = Observable.just([
        TeritaryBothData(imgName: "Male", title: "남성"),
        TeritaryBothData(imgName: "Female", title: "여성")
    ])
    let selectedGenderIndex = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    let birthTextRelay = BehaviorRelay<String?>(value: nil)
    
    let jobs: Observable<[Job]> = Observable.just([
        Job(title: "중·고등학생", imgName: "HighSchool"),
        Job(title: "대학(원)생", imgName: "University"),
        Job(title: "취업준비생", imgName: "Jobseeker"),
        Job(title: "직장인", imgName: "Worker"),
        Job(title: "주부", imgName: "Housewife"),
        Job(title: "기타", imgName: "Etc")
    ])
    let selectedJobIndex = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    let jobetcTextRelay = BehaviorRelay<String>(value: "")
    
    
    let purposeList: Observable<[TeritaryBothData]> = Observable.just([
            TeritaryBothData(imgName: "Pen", title: "학업/진로"),
            TeritaryBothData(imgName: "Handshake", title: "대인 관계"),
            TeritaryBothData(imgName: "Values", title: "성격/가치관"),
            TeritaryBothData(imgName: "Magnet", title: "행동/습관"),
            TeritaryBothData(imgName: "Health", title: "건강"),
            TeritaryBothData(imgName: "Etc", title: "기타")
        ])
    let selectedPurposeIndex = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
}

extension SignUpViewModel {
    func checkNickname() {
        let request = CheckNicknameRequest(nickname: nicknameTextRelay.value)
        LoginAPI.checkNickname(request: request)
            .subscribe(onNext: { [weak self] response in
                
            }, onError: { [weak self] error in
                
            })
            .disposed(by: disposeBag)
    }
    
    func checkJobInfo() {
        let request = JobInfoRequest(job: selectedJobIndex.value.row, jobName: jobetcTextRelay.value)
        LoginAPI.checkJobInfo(request: request)
            .subscribe(onNext: { [weak self] response in
                
            }, onError: { [weak self] error in
                
            })
            .disposed(by: disposeBag)
    }
    
//    func postSignUp() {
//        let request = SignUpRequest(nickname: nicknameTextRelay.value, purpose: selectedPurposeIndex.value.row, job: selectedJobIndex.value.row, socialId: <#T##String#>, socialLoginType: <#T##String#>)
//        LoginAPI.postSignUp(request: request)
//            .subscribe(onNext: { [weak self] response in
//                
//            }, onError: { [weak self] error in
//                
//            })
//            .disposed(by: disposeBag)
//    }
}
