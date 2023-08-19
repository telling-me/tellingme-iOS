//
//  BackHeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import UIKit
import RxSwift
import RxCocoa

protocol BackHeaderViewDelegate: AnyObject {
    func popViewController()
}

class BackHeaderView: UIView {
    weak var delegate: BackHeaderViewDelegate?

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = UIColor(named: "Gray6")
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var backButtonTapObservable: Observable<Void> {
         return backButton.rx.tap.asObservable()
     }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        backgroundColor = UIColor(named: "Side100")
        addSubview(backButton)

        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21).isActive = true
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true

        backButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }

    @objc func didTapButton(_ sender: UIButton) {
        delegate?.popViewController()
    }
}

class BackEmotionHeaderView: BackHeaderView {
    let emotionView = EmotionView()

    let reportButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "siren"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        return button
    }()

    var reportButtonTapObservable: Observable<Void> {
         return reportButton.rx.tap.asObservable()
     }

    override func setView() {
        super.setView()
        addSubview(emotionView)
        emotionView.translatesAutoresizingMaskIntoConstraints = false
        emotionView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        emotionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emotionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func setDataWithReport(index: Int) {
        emotionView.setText(index: index)

        addSubview(reportButton)
        reportButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        reportButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        reportButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -21).isActive = true
        reportButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    func setDataWithMenu() {

    }
}
