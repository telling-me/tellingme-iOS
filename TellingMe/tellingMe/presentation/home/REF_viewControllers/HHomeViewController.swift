//
//  HHomeViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import RxCocoa
import RxSwift

final class HHomeViewController: BBaseViewController {

    // MARK: - Properties
    private let viewModel = HHomeViewModel()
    private let disposeBag = DisposeBag()
    private let timeManager = TimeManager.shared
    
    // MARK: - UI Components
    private let headerView = HomeHeaderView()
    private let consecutiveDateHoverView = HomeHoverView()
    private let rotatingImageView = UIImageView()
    private let animatingImageView = UIImageView()
    private let questionView = HomeQuestionView()
    
    // MARK: - Pop Ups
    private let blurView = BlurredBackgroundView(frame: .zero, backgroundColor: .Black, opacity: 0.2, blurEffect: .regular)
    private let pushNotificationPermitView = HomePushNotificationPopUpView()
    private let networkErrorPopUpView = NetworkErrorPopUpView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        passDeviceDimension()
        setNotificationCenterForBecomeActive()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNewQuestionIfNeeded()
        animateBackground()
        checkIsTodayAnswered()
        checkTodayDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkNewIncomingAlarms()
        animateBackground()
    }
    
    // MARK: - Bindings
    override func bindViewModel() {
        // MARK: Views
        headerView.alarmButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                let alarmViewController = AlarmViewController()
                alarmViewController.delegate = self
                let newNavigationController = UINavigationController(rootViewController: alarmViewController)
                newNavigationController.modalPresentationStyle = .fullScreen
                self.present( newNavigationController, animated: true)
            }
            .disposed(by: disposeBag)
        
        headerView.myPageButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                let myPageViewController = MyPageViewController()
                let isDeviceAbnormal: Bool = UserDefaults.standard.bool(forKey: StringLiterals.isDeviceAbnormal)
                
                myPageViewController.hidesBottomBarWhenPushed = true
                myPageViewController.setAbnormalDeviceForLayout(isDeviceAbnormal: isDeviceAbnormal)
                self.navigationController?.pushViewController(myPageViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        pushNotificationPermitView.declineButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                viewModel.inputs.declinePushNotification()
                self.blurView.removeFromSuperview()
                self.pushNotificationPermitView.removeFromSuperview()
                self.tabBarController?.tabBar.isHidden = false
            }
            .disposed(by: disposeBag)
        
        pushNotificationPermitView.permitButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                viewModel.inputs.permitPushNotification()
                self.blurView.removeFromSuperview()
                self.pushNotificationPermitView.removeFromSuperview()
                self.tabBarController?.tabBar.isHidden = false
            }
            .disposed(by: disposeBag)
                
        // MARK: ViewModels
        viewModel.outputs.todayQuestion
            .bind { [weak self] response in
                print(response, "📕")
                guard let self else { return }
                switch response.isErrorOccured {
                case false:
                    self.questionView.questionBoxView.setTitles(question: response.title, phrase: response.phrase)
                    self.questionView.todayDateView.setDate(date: response.date)
                case true:
                    self.showNetworkErrorPopUp()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.isQuestionAnswered
            .asDriver()
            .drive { [weak self] isAnswered in
                guard let self else { return }
                self.questionView.isAnswered(isAnswered)
            }
            .disposed(by: disposeBag)
            
        viewModel.outputs.pushNotificationPermission
            .bind { [weak self] permission in
                guard let self, let permission else { return }
                if permission.errorMessage == nil {
                    return
                } else {
                    self.showPushNotification()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.answerInRow
            .asDriver()
            .drive { [weak self] day in
                guard let self else { return }
                self.consecutiveDateHoverView.setConsecutiveLabel(day: day)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.isAlarmUnread
            .asDriver()
            .drive { [weak self] isUnread in
                guard let self else { return }
                self.headerView.checkIfNewAlarmsExist(isUnread)
            }
            .disposed(by: disposeBag)
        
        questionView.writeButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                if viewModel.isQuestionAnswered.value != false {
                    self.pushToAnswerCompletedViewController()
                } else {
                    self.pushToAnswerViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Styles
    override func setStyles() {
        view.backgroundColor = .Side100
        
        rotatingImageView.do {
            $0.image = ImageLiterals.HomeRotatingImage
            $0.contentMode = .scaleAspectFit
        }
        
        animatingImageView.do {
            $0.image = ImageLiterals.HomeFloatingImage
            $0.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        let viewWidth = view.frame.size.width
        
        view.addSubviews(headerView, consecutiveDateHoverView, rotatingImageView,
                         animatingImageView, questionView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(66)
        }
        
        consecutiveDateHoverView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.width.greaterThanOrEqualTo(121)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
        }
        
        rotatingImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(12)
            $0.size.equalTo(viewWidth + 34)
        }
        
        animatingImageView.snp.makeConstraints {
            $0.center.equalTo(rotatingImageView.snp.center)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(animatingImageView.snp.width)
        }
        
        questionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(rotatingImageView.snp.centerY).offset(8)
            $0.height.greaterThanOrEqualTo(346)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

    // MARK: - Helpers
extension HHomeViewController {
    
    private func checkNewIncomingAlarms() {
        viewModel.refreshNewIncomingAlarms()
    }
    
    private func checkNewQuestionIfNeeded() {
        if timeManager.shouldRefreshQuestion() != false {
            viewModel.refreshQuestion()
        }
    }
    
    private func setNotificationCenterForBecomeActive() {
        print("NotificationCenter Added for background check.")
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNetwork), name: Notification.Name("RefreshHomeView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshAnimation), name: Notification.Name("RefreshAnimation"), object: nil)
    }
    
    private func animateBackground() {
        animatingImageView.transform = .identity
        rotatingImageView.transform = .identity
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: { [weak self] in
            let scale = CGAffineTransform(translationX: 0, y: 10)
            self?.animatingImageView.transform = scale
        })

        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear], animations: { [weak self] in
            let scale = CGAffineTransform(rotationAngle: .pi / 2)
            self?.rotatingImageView.transform = scale
        })
    }
    
    private func checkIsTodayAnswered() {
        viewModel.refreshIsAnsweredToday()
    }
    
    private func checkTodayDate() {
        viewModel.refreshIsAnsweredToday()
    }
    
    private func passDeviceDimension() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let height = view.frame.size.height
        let width = view.frame.size.width
        
        appDelegate.setDeviceDimensions(height: height, width: width)
    }
}
    // MARK: - Presentations
extension HHomeViewController {
    
    private func showPushNotification() {
        self.view.addSubviews(blurView, pushNotificationPermitView)
        self.tabBarController?.tabBar.isHidden = true

        blurView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        pushNotificationPermitView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(362)
        }
        
        pushNotificationPermitView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.pushNotificationPermitView.transform = .identity
        }
    }
    
    private func pushToAnswerViewController() {
        let storyboard = UIStoryboard(name: "Answer", bundle: nil)
        guard let answerViewController = storyboard.instantiateViewController(identifier: "answer") as? AnswerViewController else { return }
        self.navigationController?.pushViewController(answerViewController, animated: true)
    }
    
    private func pushToAnswerCompletedViewController() {
        let storyboard = UIStoryboard(name: "AnswerCompleted", bundle: nil)
        guard let answerCompletedViewController = storyboard.instantiateViewController(withIdentifier: "answerCompleted") as? AnswerCompletedViewController else { return }
        guard let date = Date().getQuestionDate() else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        answerCompletedViewController.setQuestionDate(date: date)
        self.navigationController?.pushViewController(answerCompletedViewController, animated: true)
    }
    
    private func showNetworkErrorPopUp() {
        view.addSubviews(blurView, networkErrorPopUpView)
        
        blurView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        networkErrorPopUpView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(networkErrorPopUpView.snp.width)
        }
        
        networkErrorPopUpView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.35) {
            self.networkErrorPopUpView.transform = .identity
        }
    }
}
    
    // MARK: - @Objcs for NotificationCenter
extension HHomeViewController {
    @objc
    private func refreshNetwork() {
        print("Back From Background, refreshed the question.")
        checkNewQuestionIfNeeded()
    }

    @objc
    private func refreshAnimation() {
        print("Back From Background, refreshed the animation.")
        animateBackground()
    }
}
    // MARK: - Delegates
extension HHomeViewController: DismissAndSwitchTabDelegate {
    func dismissAndSwitchTab(to index: Int) {
        self.tabBarController?.selectedIndex = index
    }
}

