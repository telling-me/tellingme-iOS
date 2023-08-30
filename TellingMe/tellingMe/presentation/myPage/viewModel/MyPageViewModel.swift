//
//  MyPageViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import RxCocoa
import RxMoya
import RxSwift

protocol MyPageInputs {
    // 나중에 사용자가 결제를 하러 들어갔다가 나온 그 횟수를 확인하기 위해
    // 외부 링크로 나가는 것은 여기서 처리
    func premiumInAppPurchaseTapped()
    func tellingMeBootPayPurchaseTapped()
    func faqTapped()
    func myProfileTapped()
    func togglePushAlarmPermission(isAllowed: Bool)
    func lockSettingTapped()
    func termsOfUseTapped()
    func privatePolicyTapped()
    func withdrawalTapped()
    func logoutTapped()
}

protocol MyPageOutputs {
    var boxElements: Observable<[MyPageBoxElementsModel]> { get }
    var settingElements: Observable<[MyPageSettingElementsModel]> { get }
    var userInformation: BehaviorRelay<MyPageResponse> { get }
}

protocol MyPageViewModelType {
    var inputs: MyPageInputs { get }
    var outputs: MyPageOutputs { get }
}

final class MyPageViewModel: MyPageInputs, MyPageOutputs, MyPageViewModelType {
    
    private let settingElementsData: [MyPageSettingElementsModel] = [
        MyPageSettingElementsModel(isElementWithToggle: true, isElementWithLogout: false, elementTitle: "푸시 알림 받기"),
        MyPageSettingElementsModel(isElementWithToggle: false, isElementWithLogout: false, elementTitle: "잠금 설정"),
        MyPageSettingElementsModel(isElementWithToggle: false, isElementWithLogout: false, elementTitle: "이용 약관"),
        MyPageSettingElementsModel(isElementWithToggle: false, isElementWithLogout: false, elementTitle: "개인정보 처리방침"),
        MyPageSettingElementsModel(isElementWithToggle: false, isElementWithLogout: false, elementTitle: "회원 탈퇴"),
        MyPageSettingElementsModel(isElementWithToggle: false, isElementWithLogout: true, elementTitle: "로그아웃")
    ]
    private let boxElementsData: [MyPageBoxElementsModel] = [
        MyPageBoxElementsModel(iconImage: "PremiumIcon", iconTitle: "프리미엄"),
        MyPageBoxElementsModel(iconImage: "TellingMeBookIcon", iconTitle: "텔링미북"),
        MyPageBoxElementsModel(iconImage: "FAQIcon", iconTitle: "FAQ"),
        MyPageBoxElementsModel(iconImage: "SettingProfileIcon", iconTitle: "내 정보")
    ]
    
    var settingElements: Observable<[MyPageSettingElementsModel]>
    var boxElements: Observable<[MyPageBoxElementsModel]>
    var userInformation: BehaviorRelay<MyPageResponse> = BehaviorRelay(value: MyPageResponse(nickname: "", profileUrl: "", answerRecord: 0, isPremium: false, allowNotification: false))
    private var disposeBag = DisposeBag()

    var inputs: MyPageInputs { return self }
    var outputs: MyPageOutputs { return self }
    
    init() {
        self.settingElements =
        Observable<[MyPageSettingElementsModel]>
            .just(settingElementsData)
        self.boxElements = Observable<[MyPageBoxElementsModel]>.just(boxElementsData)
        fetchUserData()
    }
    
    func premiumInAppPurchaseTapped() {
        
    }
    
    func tellingMeBootPayPurchaseTapped() {
        
    }
    
    func faqTapped() {
        
    }
    
    func myProfileTapped() {
        
    }
    
    func togglePushAlarmPermission(isAllowed: Bool) {
        // 여기서 통신하고, 바꾸거나 설정으로 넘어가게 만들기
    }
    
    func lockSettingTapped() {
        
    }
    
    func termsOfUseTapped() {
        
    }
    
    func privatePolicyTapped() {
        
    }
    
    func withdrawalTapped() {
        
    }
    
    func logoutTapped() {
        
    }
}

extension MyPageViewModel {
    private func fetchUserData() {
        guard let currentDate = Date().getQuestionDate() else {
            print("Date Converting Failed at MyPage")
            return
        }
        
        MyPageAPI.getMyPageInformation(request: .init(date: currentDate))
            .subscribe(onNext: { [weak self] response in
                self?.userInformation.accept(response)
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
    }
}
