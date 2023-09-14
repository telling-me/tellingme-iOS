//
//  MyPageViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import RxCocoa
import RxDataSources
import RxMoya
import RxSwift

protocol MyPageInputs {
    // 1. 나중에 사용자가 결제를 하러 들어갔다가 나온 그 횟수를 확인하기 위해
    // 2. 외부 링크로 나가는 것은 여기서 처리
    // 3. Coordinator 처리하기 위해
    func premiumInAppPurchaseTapped()
    func tellingMeBootPayPurchaseTapped()
    func faqTapped()
    func myProfileTapped()
    func togglePushAlarmPermission(to: Bool)
    func lockSettingTapped()
    func termsOfUseTapped()
    func privatePolicyTapped()
    func feedBackWithMailTapped()
    func withdrawalTapped()
    func questionPlantTapped()
    func logoutTapped()
}

protocol MyPageOutputs {
    var boxElements: Observable<[MyPageBoxElementsModel]> { get }
    var settingElements: Observable<[MyPageSettingElementsModel]> { get }
    var userInformation: BehaviorRelay<MyPageResponse> { get }
    var premiumInformation: Observable<[SectionOfPremiumInformation]> { get }
}

protocol MyPageViewModelType {
    var inputs: MyPageInputs { get }
    var outputs: MyPageOutputs { get }
}

final class MyPageViewModel: MyPageInputs, MyPageOutputs, MyPageViewModelType {
    
    typealias PremiumImageName = String
    
    private let userDefaults = UserDefaults.standard
    private let settingViewModel = SettingViewModel()

    private let settingElementsData: [MyPageSettingElementsModel] = [
        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "푸시 알림 받기"),
//        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "잠금 설정"),
        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "이용 약관"),
        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "개인정보 처리방침"),
        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "고객 센터"),
        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "듀이의 질문 제작소"),
        MyPageSettingElementsModel( isElementWithLogout: false, elementTitle: "회원 탈퇴"),
        MyPageSettingElementsModel( isElementWithLogout: true, elementTitle: "로그아웃")
    ]
    private let boxElementsData: [MyPageBoxElementsModel] = [
        MyPageBoxElementsModel(iconImage: "PremiumIcon", iconTitle: "프리미엄"),
        MyPageBoxElementsModel(iconImage: "TellingMeBookIcon", iconTitle: "텔링e북"),
        MyPageBoxElementsModel(iconImage: "FAQIcon", iconTitle: "FAQ"),
        MyPageBoxElementsModel(iconImage: "SettingProfileIcon", iconTitle: "내 정보")
    ]
    private let premiumInfoImageNames: [SectionOfPremiumInformation] = [SectionOfPremiumInformation(header: "premiumHeader", footer: "premiumFooter", items: ["PremiumInfo1", "PremiumInfo2", "PremiumInfo3", "PremiumInfo4", "PremiumInfo5"])]

    var settingElements: Observable<[MyPageSettingElementsModel]>
    var boxElements: Observable<[MyPageBoxElementsModel]>
    var userInformation: BehaviorRelay<MyPageResponse> = BehaviorRelay(value: MyPageResponse(nickname: "", profileUrl: "", answerRecord: 0, isPremium: false, allowNotification: false))
    var premiumInformation: Observable<[SectionOfPremiumInformation]>
    
    private var disposeBag = DisposeBag()

    var inputs: MyPageInputs { return self }
    var outputs: MyPageOutputs { return self }
    
    init() {
        self.settingElements =
        Observable<[MyPageSettingElementsModel]>
            .just(settingElementsData)
        self.boxElements = Observable<[MyPageBoxElementsModel]>.just(boxElementsData)
        self.premiumInformation = Observable.just(premiumInfoImageNames)
        fetchUserData()
    }
    
    /// 1. 추적용 2. Coordinator 용
    func premiumInAppPurchaseTapped() {
        print("Premium Tapped")
    }
    
    /// 1. 추적용 2. Coordinator 용
    func tellingMeBootPayPurchaseTapped() {
        print("TellingMe Book Purchase Tapped")
    }
    
    func faqTapped() {
        if let url = URL(string: UrlLiterals.faqUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    /// 1. Coordinator 용
    func myProfileTapped() {
        print("Profile Tapped")
    }
    
    func togglePushAlarmPermission(to permission: Bool) {
        print("🧩 Posting Push Permission Sent to the server. : toggled to - \(permission)")
        settingViewModel.postNotification(permission)
    }
    
    func lockSettingTapped() {
        
    }
    
    func termsOfUseTapped() {
        if let url = URL(string: UrlLiterals.termsOfUseUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    func privatePolicyTapped() {
        if let url = URL(string: UrlLiterals.privacyPolicyUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    /// 1. 추적용 2. Coordinator 용
    func feedBackWithMailTapped() {
        print("FeedBack Tapped")
    }
    
    func questionPlantTapped() {
        if let url = URL(string: UrlLiterals.questionPlant) {
            UIApplication.shared.open(url)
        }
    }
    
    func withdrawalTapped() {
        print("Withdrawal Tapped")
    }
    
    func logoutTapped() {
        print("Logout Tapped")
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
                let isPushNotificationPermittedKey = StringLiterals.isPushNotificationPermittedKey
                self?.userInformation.accept(response)
                self?.userDefaults.bool(forKey: isPushNotificationPermittedKey)
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
    }
}
