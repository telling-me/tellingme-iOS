//
//  CustomTextView.swift
//  tellingMe
//
//  Created by 마경미 on 14.09.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: placeholder를 두기 위한 custom textView
final class CustomTextView: UITextView {
    private let placeholderLabel = UILabel()
    private let disposeBag = DisposeBag()

    internal var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
        observeTextView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        observeTextView()
    }

    private func setupUI() {
        addSubview(placeholderLabel)

        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(5)
            $0.trailing.equalTo(self).offset(-5)
            $0.top.equalTo(self).offset(8)
        }
    }

    private func observeTextView() {
        rx.text.orEmpty
            .bind(onNext: { [weak self] text in
                self?.placeholderLabel.isHidden = !text.isEmpty
            })
            .disposed(by: disposeBag)
    }
}
