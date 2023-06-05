//
//  HomeViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.03.23.
//

import UIKit

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()

    @IBOutlet weak var headerView: HeaderView!
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        animation()
        getQuestion()
        getAnswerRecord()
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

        if let selectedViewController = self.tabBarController?.selectedViewController,
           selectedViewController != self.navigationController {
            self.tabBarController?.tabBar.isHidden = true
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

    func pushEmotion() {
        let storyboard = UIStoryboard(name: "Answer", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "answer") as? AnswerViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func pushAnswerCompleted() {
        let storyboard = UIStoryboard(name: "AnswerCompleted", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "answerCompleted") as? AnswerCompletedViewController else { return }
        vc.setQuestionDate(date: viewModel.questionDate)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func presentEmotion(_ sender: UIButton) {
        getTodayAnswer()
    }
}

extension HomeViewController: HeaderViewDelegate {
    func pushSetting(_ headerView: HeaderView) {
        // push를 수행하는 코드
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "setting") as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
