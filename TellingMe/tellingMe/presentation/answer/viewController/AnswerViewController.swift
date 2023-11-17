//
//  AnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.05.23.
//

import UIKit

import RxCocoa
import RxSwift

class AnswerViewController: UIViewController, ModalActionDelegate {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var subQuestionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!

    @IBOutlet weak var emotionView: UIView!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var emotionLabel: Body2Bold!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!

    @IBOutlet weak var countTextLabel: UILabel!
    @IBOutlet weak var textLimitLabel: UILabel!
    @IBOutlet weak var foldView: UIView!
    @IBOutlet weak var foldViewHeight: NSLayoutConstraint!

    @IBOutlet weak var publicSwitch: UISwitch!

    let viewModel = AnswerViewModel()
    let changeToSpareQuestionView = ChangeToSpareQuestionView()
    let changeToOriginQuestionView = ChangeToOriginQuestionView()

    var typeLimit: Int = 300
    
    private let disposeBag = DisposeBag()
    
    var isSpare: Bool = false
    var todayQuestion: Question = .init(date: nil, question: "", phrase: "")
    var spareQuestion: SpareQuestion = .init(date: nil, spareQuestion: "", sparePhrase: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestion()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.dayLabel.text = viewModel.date
        switch IAPManager.getHasUserPurchased() {
        case true:
            self.typeLimit = 500
            self.textLimitLabel.text = "/ \(typeLimit)"
        case false:
            self.textLimitLabel.text = "/ \(typeLimit)"
        }

        bindViewModel()
        setStyles()
        setLayout()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if answerTextView.text.count > self.typeLimit {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            answerTextView.text.removeLast()
            countTextLabel.text = "\(typeLimit)"
        }
         answerTextView.resignFirstResponder()
     }

    func showEmotion() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "emotion") as? EmotionViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.delegate = self
        vc.viewModel.selectedEmotion = self.viewModel.emotion
        self.present(vc, animated: false)
    }

    func showModal(id: String) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: id) as? ModalViewController else {
            return
        }
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: false)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        // 키보드 높이 계산
        let keyboardHeight = keyboardFrame.size.height
        bottomLayout.constant = keyboardHeight - view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomLayout.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func clickBack(_ sender: UIButton) {
        viewModel.modalChanged = 0
        showModal(id: "cancelAnswerModal")
    }

    @IBAction func changeQuestion(_ sender: UIButton) {
        if isSpare {
            showChangeToOriginQuestionView()
        } else {
            showChangeToSpareQuestionView()
        }
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        viewModel.modalChanged = 1
        if answerTextView.text.count > self.typeLimit {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            answerTextView.text.removeLast()
            countTextLabel.text = "\(self.typeLimit)"
        } else if answerTextView.text.count <= 3 {
            self.showToast(message: "4글자 이상 작성해주세요")
            answerTextView.resignFirstResponder()
        } else {
            showEmotion()
        }
    }

    @IBAction func foldView(_ sender: UIButton) {
        if foldViewHeight.constant == 0 {
            self.foldView.isHidden = false
            self.foldViewHeight.constant = 120
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            self.foldView.isHidden = true
            self.foldViewHeight.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }

    func clickCancel() {
    }

    // 답변 등록하기 버튼
    func clickOk() {
        if viewModel.modalChanged == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.postAnswer()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showChangeToSpareQuestionView() {
        changeToSpareQuestionView.setQuestion(todayQuestion: todayQuestion, specialQuestion: spareQuestion)
        changeToSpareQuestionView.isHidden = false
        changeToSpareQuestionView.animate()
    }
    
    func showChangeToOriginQuestionView() {
        changeToOriginQuestionView.setQuestion(todayQuestion: todayQuestion)
        changeToOriginQuestionView.isHidden = false
        changeToOriginQuestionView.animate()
    }
}

extension AnswerViewController {
    private func bindViewModel() {
        changeToSpareQuestionView.okButtonTapObserver
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.isSpare = true
                self.changeToSpareQuestionView.isHidden = true
                self.setSpareQuestion()
            })
            .disposed(by: disposeBag)
        changeToOriginQuestionView.okButtonTapObserver
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.isSpare = false
                self.changeToOriginQuestionView.isHidden = true
                self.setOriginQuestion()
            })
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        changeToSpareQuestionView.do {
            $0.isHidden = true
        }
        
        changeToOriginQuestionView.do {
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        view.addSubviews(changeToSpareQuestionView, changeToOriginQuestionView)
        
        changeToSpareQuestionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        changeToOriginQuestionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AnswerViewController {
    private func setSpareQuestion() {
        questionLabel.text = spareQuestion.spareQuestion
        subQuestionLabel.text = spareQuestion.sparePhrase
    }
    
    private func setOriginQuestion() {
        questionLabel.text = todayQuestion.question
        subQuestionLabel.text = todayQuestion.phrase
    }
}
