//
//  AgreementBottomSheetViewController.swift
//  tellingMe
//
//  Created by 마경미 on 03.10.23.
//

import UIKit

import SnapKit
import Then

final class AgreementBottomSheetViewController: BaseViewController {
    private var index: Int
    
    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let textView = UITextView()
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setStyles()
    }
    
    deinit {
        print("AgreementBottomSheetViewController Deinited")
    }
}

extension AgreementBottomSheetViewController {
    private func setLayout() {
        view.addSubviews(titleLabel, containerView)
        containerView.addSubview(textView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        textView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.font = .fontNanum(.B1_Bold)
            $0.textColor = .Gray7
            $0.textAlignment = .center
            switch index {
            case 0:
                $0.text = "서비스 이용약관 동의"
            case 1:
                $0.text = "개인정보 수집 및 이용 동의"
            default:
                break
            }
        }
        
        containerView.do {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .Side200
        }
        
        textView.do {
            $0.backgroundColor = .clear
            $0.isEditable = false
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .black
            switch index {
            case 0:
                $0.text = readText(fileName: "TermofUse")
            case 1:
                $0.text = readText(fileName: "PrivacyPolicy")
            default:
                break
            }
        }
    }
}

extension AgreementBottomSheetViewController {
    func readText(fileName: String) -> String {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
                return fileContents
            } catch {
                self.showToast(message: "파일을 읽을 수 없습니다.")
            }
        } else {
            self.showToast(message: "파일을 찾을 수 없습니다.")
        }
        return "파일을 찾을 수 없습니다."
    }
}
