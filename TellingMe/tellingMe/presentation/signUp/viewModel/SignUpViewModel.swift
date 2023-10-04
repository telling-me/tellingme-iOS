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

protocol SignUpViewModelInputs {
    var agreementRelays: [BehaviorRelay<Bool>] { get }
    var nicknameTextRelay: BehaviorRelay<String> { get }
    var birthTextRelay: BehaviorRelay<String?> { get }
    var selectedGenderIndex: BehaviorRelay<String?> { get }
    var selectedJobIndex: BehaviorRelay<IndexPath?> { get }
    var jobetcTextRelay: BehaviorRelay<String?> { get }
    var selectedPurposeIndex: BehaviorRelay<[Int]> { get }
    
    func checkNickname()
    func checkJobInfo()
    func postSignUp()
    func checkAllAgreed()
    func checkNicknameInputed()
    func checkJobSelected(_: IndexPath?)
    func checkPurposeSelected()
}

protocol SignUpViewModelOutputs {
    var viewControllers: [UIViewController] { get }
    var agreements: [String] { get }
    var genderList: Observable<[TeritaryBothData]> { get }
    var jobs: Observable<[Job]> { get }
    var purposeList: Observable<[TeritaryBothData]> { get }
    var checkNicknameSuccessSubject: BehaviorSubject<EmptyResponse> { get }
    var checkJobInfoSuccessSubject: BehaviorSubject<EmptyResponse> { get }
    var showInfoSubject: BehaviorSubject<Void> { get }
    var errorToastSubject: BehaviorSubject<String> { get }
    
    var nextButtonEnabledRelay: BehaviorRelay<Bool> { get }
    var showJobEtcSubject: BehaviorRelay<Bool> { get }
}

protocol SignUpViewModelType {
    var inputs: SignUpViewModelInputs { get }
    var outputs: SignUpViewModelOutputs { get }
}

final class SignUpViewModel: SignUpViewModelType, SignUpViewModelInputs, SignUpViewModelOutputs {
    var jobCount: Int { return 6 }
    var badWordsArray: [String] {
        var tempArray: [String] = []
        if let filepath = Bundle.main.path(forResource: "badWords", ofType: "txt" ) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let lines = contents.components(separatedBy: ",")
                tempArray.append(contentsOf: lines)
            } catch {
                print("Error: \(error)")
            }
        }
        return tempArray
    }

    private let disposeBag = DisposeBag()
    
    var currentIndex: Int = 0
    
    // inputs
    var inputs: SignUpViewModelInputs { return self }
    lazy var viewControllers: [UIViewController] = {
        return [
            AgreementViewController(viewModel: self),
            NickNameViewController(viewModel: self),
            OptionViewController(viewModel: self),
            JobViewController(viewModel: self),
            PurposeViewController(viewModel: self)
        ]
    }()
    let agreementRelays: [BehaviorRelay<Bool>] = [BehaviorRelay(value: false), BehaviorRelay(value: false)]
    let agreements: [String] = ["(필수) 서비스 이용약관 동의", "(필수) 개인정보 수집 및 이용 동의"]
    let nicknameTextRelay = BehaviorRelay<String>(value: "")
    let genderList: Observable<[TeritaryBothData]> = Observable.just([
        TeritaryBothData(imgName: "Male", title: "남성"),
        TeritaryBothData(imgName: "Female", title: "여성")
    ])
    let birthTextRelay = BehaviorRelay<String?>(value: nil)
    let selectedGenderIndex = BehaviorRelay<String?>(value: nil)
    let jobs: Observable<[Job]> = Observable.just([
        Job(title: "중·고등학생", imgName: "HighSchool"),
        Job(title: "대학(원)생", imgName: "University"),
        Job(title: "취업준비생", imgName: "Jobseeker"),
        Job(title: "직장인", imgName: "Worker"),
        Job(title: "주부", imgName: "Housewife"),
        Job(title: "기타", imgName: "Etc")
    ])
    let selectedJobIndex = BehaviorRelay<IndexPath?>(value: nil)
    let jobetcTextRelay = BehaviorRelay<String?>(value: nil)
    let purposeList: Observable<[TeritaryBothData]> = Observable.just([
        TeritaryBothData(imgName: "Pen", title: "학업/진로"),
        TeritaryBothData(imgName: "Handshake", title: "대인 관계"),
        TeritaryBothData(imgName: "Values", title: "성격/가치관"),
        TeritaryBothData(imgName: "Magnet", title: "행동/습관"),
        TeritaryBothData(imgName: "Health", title: "건강"),
        TeritaryBothData(imgName: "Etc", title: "기타")
    ])
    let selectedPurposeIndex = BehaviorRelay<[Int]>(value: [])
    
    // outputs
    var outputs: SignUpViewModelOutputs { return self }
    let checkNicknameSuccessSubject = BehaviorSubject<EmptyResponse>(value: .init())
    let checkJobInfoSuccessSubject = BehaviorSubject<EmptyResponse>(value: .init())
    let showInfoSubject = BehaviorSubject<Void>(value: ())
    let errorToastSubject = BehaviorSubject<String>(value: "")
    let nextButtonEnabledRelay = BehaviorRelay<Bool>(value: false)
    var showJobEtcSubject = BehaviorRelay<Bool>(value: false)

    func checkAllAgreed() {
        for agreementRelay in agreementRelays {
            if !agreementRelay.value {
                outputs.nextButtonEnabledRelay.accept(false)
                return
            }
        }
        
        outputs.nextButtonEnabledRelay.accept(true)
    }
    
    func checkNicknameInputed() {
        if nicknameTextRelay.value.count >= 2 && nicknameTextRelay.value.count < 9 {
            outputs.nextButtonEnabledRelay.accept(true)
        } else {
            outputs.nextButtonEnabledRelay.accept(false)
        }
    }
    
    func checkJobSelected(_ indexPath: IndexPath?) {
        if indexPath != nil {
            selectedJobIndex.accept(indexPath)
        }
        
        if let indexPath = selectedJobIndex.value {
            outputs.nextButtonEnabledRelay.accept(true)
            
            if indexPath.row == jobCount - 1 {
                outputs.showJobEtcSubject.accept(true)
            } else {
                outputs.showJobEtcSubject.accept(false)
            }
        } else {
            outputs.nextButtonEnabledRelay.accept(false)
        }
    }
    
    func checkPurposeSelected() {
        if selectedPurposeIndex.value.isEmpty {
            outputs.nextButtonEnabledRelay.accept(false)
        } else {
            outputs.nextButtonEnabledRelay.accept(true)
        }
    }
}

extension SignUpViewModel {
    func checkNickname() {
        for word in badWordsArray where nicknameTextRelay.value.contains(word) {
            outputs.errorToastSubject.onNext("사용할 수 없는 닉네임입니다")
            return
        }
        
        let request = CheckNicknameRequest(nickname: nicknameTextRelay.value)

        LoginAPI.checkNickname(request: request)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                checkNicknameSuccessSubject.onNext(response)
            }, onError: { [weak self] error in
                guard let self else { return }
                switch error {
                case APIError.errorData(let errorData):
                    errorToastSubject.onNext(errorData.message)
                default:
                    print("Error occured during check nickname : \(error)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func checkJobInfo() {
        guard let jobIndexValue = selectedJobIndex.value else {
            self.errorToastSubject.onNext("직업을 선택해주세요.")
            return
        }
        
        guard let jobInfovalue = jobetcTextRelay.value else {
            self.errorToastSubject.onNext("기타 직업을 직접 입력해주세요.")
            return
        }
        
        let request = JobInfoRequest(job: jobIndexValue.row, jobName: jobInfovalue)
        LoginAPI.checkJobInfo(request: request)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                checkJobInfoSuccessSubject.onNext(response)
            }, onError: { [weak self] error in
                guard let self else { return }
                switch error {
                case APIError.errorData(let errorData):
                    errorToastSubject.onNext(errorData.message)
                default:
                    print("Error occured during check job info : \(error)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func postSignUp() {
        guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue),
              let socialLoginType = KeychainManager.shared.load(key: Keys.socialLoginType.rawValue),
              let jobIndex = selectedJobIndex.value else {
            return
        }
        
        let request = SignUpRequest(nickname: nicknameTextRelay.value, purpose: selectedPurposeIndex.value.sorted().intArraytoString(), job: jobIndex.row, jobInfo: jobetcTextRelay.value, gender: selectedGenderIndex.value, birthDate: birthTextRelay.value, socialId: socialId, socialLoginType: socialLoginType)
        LoginAPI.postSignUp(request: request)
            .subscribe(onNext: { [weak self] response in
                
            }, onError: { [weak self] error in
                
            })
            .disposed(by: disposeBag)
    }
}
