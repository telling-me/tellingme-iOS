//
//  AgreementViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class AgreementViewController: SignUpBaseViewController {
    private let viewModel: SignUpViewModel
    private let disposeBag = DisposeBag()
    
    private let boxCheckButton = BoxCheckboxView()
    private let agreementStackView = UIStackView()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.inputs.checkAllAgreed()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func bindViewModel() {
        boxCheckButton.checkButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.boxCheckButton.checkButton.isSelected.toggle()
                self.toggleAllAgreements(isAgree: boxCheckButton.checkButton.isSelected)
            })
            .disposed(by: disposeBag)
    }
    
    override func setStyles() {
        titleLabel.do {
            $0.text = "약관에 동의해주세요"
        }
        
        boxCheckButton.do {
            $0.setCheckbox(title: "모두 동의할게요")
        }
        
        agreementStackView.do {
            $0.axis = .vertical
            $0.spacing = 12
            setStackView()
        }
    }
    
    override func setLayout() {
        view.addSubviews(boxCheckButton, agreementStackView)
        boxCheckButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(110)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(56)
        }
        
        agreementStackView.snp.makeConstraints {
            $0.top.equalTo(boxCheckButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(41)
            $0.height.equalTo(60)
        }
    }
    
    deinit {
        print("AgreementViewController Deinited")
    }
}

extension AgreementViewController {
    private func setStackView() {
        for (index, agreement) in viewModel.agreements.enumerated() {
            let checkboxView = CheckboxView()
            checkboxView.setCheckbox(title: agreement, subButtonTitle: "자세히")
            agreementStackView.addArrangedSubview(checkboxView)
            
            checkboxView.checkButton.rx.tap
                .bind(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    toggleAgreement(index: index)
                })
                .disposed(by: disposeBag)
            checkboxView.subButton.rx.tap
                .bind(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.showAgreementDetailSheet(index)
                }).disposed(by: disposeBag)
        }
    }

    private func showAgreementDetailSheet(_ index: Int) {
        let bottomSheetViewController = AgreementBottomSheetViewController(index: index)
        bottomSheetViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = bottomSheetViewController.sheetPresentationController {
            sheet.detents = [.custom { _ in
                return 447
            }]
            sheet.preferredCornerRadius = 28
            sheet.prefersGrabberVisible = true
        }
        present(bottomSheetViewController, animated: true)
    }
    
    private func toggleAllAgreements(isAgree: Bool) {
        for (index, checkboxView) in agreementStackView.arrangedSubviews.enumerated() {
            guard let checkboxView = checkboxView as? CheckboxView else {
                return
            }
            
            checkboxView.checkButton.isSelected = isAgree
            self.viewModel.agreementRelays[index].accept(isAgree)
            viewModel.inputs.checkAllAgreed()
        }
    }
    
    private func toggleAgreement(index: Int) {
        guard let checkboxView = agreementStackView.arrangedSubviews[index] as? CheckboxView else {
            return
        }
        checkboxView.checkButton.isSelected.toggle()
        self.viewModel.agreementRelays[index].accept(checkboxView.checkButton.isSelected)
    
        viewModel.inputs.checkAllAgreed()
    }
}

