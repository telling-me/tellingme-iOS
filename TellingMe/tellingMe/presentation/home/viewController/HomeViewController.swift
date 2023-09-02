//
//  HomeViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.03.23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()

    @IBOutlet weak var headerView: MainSettingHeaderView!
    @IBOutlet weak var dayStackView: UIView!
    @IBOutlet weak var dayStackLabel: CaptionLabelBold!
    @IBOutlet weak var dayLabel: CaptionLabelRegular!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var subQuestionLabel: Body2Regular!
    @IBOutlet weak var questionLabel: Body1Regular!
    @IBOutlet var animationViews: [UIImageView]!
    @IBOutlet var shadowViews: [UIImageView]!
    @IBOutlet weak var rotateAnimationView: UIImageView!
    @IBOutlet weak var answerCompletedLabel: CaptionLabelRegular!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        checkNofitication()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getQuestion()
        getAnswerRecord()
        getAnswer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation()
        getNotice()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animationViews.forEach { $0.transform = .identity }
        rotateAnimationView.transform = .identity
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.animationViews[0].stopAnimating()
        self.animationViews[1].stopAnimating()
        self.animationViews[2].stopAnimating()
        self.animationViews[3].stopAnimating()
        for animationView in animationViews {
            animationView.layer.removeAllAnimations()
        }
    }

    func setView() {
        questionView.setShadow(shadowRadius: 20)
        dayStackView.setShadow(shadowRadius: 20)
        writeButton.setShadow(shadowRadius: 16)

        questionLabel.textColor = UIColor(named: "Logo")
        subQuestionLabel.textColor = UIColor(named: "Gray5")
        dayLabel.textColor = UIColor(named: "Side500")

        dayLabel.text = viewModel.today
        for view in shadowViews {
            view.setShadow2()
        }

        headerView.delegate = self
    }

    func animation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            let scale = CGAffineTransform(translationX: 0, y: 10)
            self.animationViews[0].transform = scale
            self.animationViews[1].transform = scale
            self.animationViews[2].transform = scale
            self.animationViews[3].transform = scale
        }

        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear]) {
            let scale = CGAffineTransform(rotationAngle: .pi / 2)
            self.rotateAnimationView.transform = scale
        }
    }

    func showPushNotification() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "pushNotificationModal") as? PushNotificationModalViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }

    func pushAnswer() {
        let storyboard = UIStoryboard(name: "Answer", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "answer") as? AnswerViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func pushAnswerCompleted() {
        let storyboard = UIStoryboard(name: "AnswerCompleted", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "answerCompleted") as? AnswerCompletedViewController else { return }
        guard let date = viewModel.questionDate else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        vc.setQuestionDate(date: date)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // firebase token 값이 keychain에 저장되어 있지 않으면 push 동의 모달창 띄우기
    func checkNofitication() {
        if let token = KeychainManager.shared.load(key: Keys.firebaseToken.rawValue) {
        } else {
            self.showPushNotification()
        }
    }

    @IBAction func presentEmotion(_ sender: UIButton) {
        if !viewModel.isAnswerCompleted {
            pushAnswer()
        } else {
            pushAnswerCompleted()
        }
    }
}

extension HomeViewController: HeaderViewDelegate {
    func pushAlarmNotice(_ headerView: MainHeaderView) {
        let vc = AlarmViewController()
        let navigationNewController = UINavigationController(rootViewController: vc)
        navigationNewController.modalPresentationStyle = .overFullScreen
        self.present(navigationNewController, animated: true)
    }
    
    func pushSetting(_ headerView: MainHeaderView) {
        // push를 수행하는 코드
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "setting") as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getNotice() {
        viewModel.getNewNotices { [weak self] isNewNotice in
            if isNewNotice != false {
                self?.headerView.alarmNoticeButton.setImage(UIImage(named: "NoticeAlarmWithDot"), for: .normal)
                print("🅾️ New Notices exist.")
            } else {
                self?.headerView.alarmNoticeButton.setImage(UIImage(named: "NoticeAlarm"), for: .normal)
                print("❎ New Notices doesn't exist.")
            }
        }
    }
    
    func bindViewModel() {
        viewModel.pushNotificationInfoSubject
            .skip(1)
            .bind(onNext: { [weak self] _ in
                self?.showPushNotification()
            })
            .disposed(by: disposeBag)
    }
}
