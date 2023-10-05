//
//  CheckboxView.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class CheckboxView: UIView {
    // checkbutton, subbutton observer를 만들고싶은데 일단 이대로 진행 ㄱㄱ
    let checkButton = UIButton()
    let subButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CheckboxButton deinit")
    }
}

extension CheckboxView {
//    private func bindViewModel() {
//        checkButton.rx.tap
//            .bind(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.checkButton.isSelected.toggle()
//                self.checkButtonTapObserver.accept(self.checkButton.isSelected)
//            })
//            .disposed(by: disposeBag)
//
//        subButton.rx.tap
//            .bind(onNext: { [weak self] in
//                guard let self = self else { return }
//                self.subButtonTapObserver.accept(())
//            })
//            .disposed(by: disposeBag)
//    }

    private func setLayout() {
        addSubviews(checkButton, subButton)
        
        checkButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
        }
        
        subButton.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.leading.equalTo(checkButton.snp.trailing)
            $0.verticalEdges.trailing.equalToSuperview()
        }
    }
    
    private func setStyles() {
        checkButton.do {
            $0.setImage(UIImage(named: "Checkbox"), for: .normal)
            $0.setImage(UIImage(named: "SelectedCheckbox"), for: .selected)
            $0.titleLabel?.font = .fontNanum(.C1_Regular)
            $0.setTitleColor(.Gray8, for: .normal)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        subButton.do {
            $0.setTitleColor(.Primary700, for: .normal)
            $0.titleLabel?.font = .fontNanum(.C1_Regular)
        }
    }
}

extension CheckboxView {
    func setCheckbox(title: String, subButtonTitle: String? = nil) {
        if let subButtonTitle = subButtonTitle {
            subButton.isHidden = false
            subButton.setTitle(subButtonTitle, for: .normal)
        } else {
            subButton.isHidden = true
        }
        checkButton.setTitle(title, for: .normal)
    }
}
