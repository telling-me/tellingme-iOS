//
//  OptionViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.10.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class OptionViewController: SignUpBaseViewController {
    private let viewModel: SignUpViewModel
    private let disposeBag = DisposeBag()
    
    private let inputBox = Input()
    private let genderTitleLabel = UILabel()
    private let genderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
        hideKeyboardWhenTappedAround()
    }
    
    deinit {
        print("OptionViewController Deinited")
    }
}

extension OptionViewController {
    private func bindViewModel() {
        genderCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        genderCollectionView.rx.itemSelected
            .map({ (indexPath) in
                if indexPath.row == 0 {
                    return "남성"
                } else if indexPath.row == 1 {
                    return "여성"
                } else {
                    return nil
                }
            })
            .bind(to: viewModel.selectedGenderIndex)
            .disposed(by: disposeBag)
        
        inputBox.inputTextField.rx.controlEvent(.editingChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      let text = self.inputBox.inputTextField.text else {
                    return
                }

                if text.count > 4 {
                    self.inputBox.inputTextField.text = String(text.prefix(4))
                    self.inputBox.hiddenKeyboard()
                }
            })
            .disposed(by: disposeBag)
        
        inputBox.inputTextField.rx.text
            .bind(to: viewModel.birthTextRelay)
            .disposed(by: disposeBag)
        
        viewModel.genderList
            .bind(to: genderCollectionView.rx.items(cellIdentifier: TeritaryVerticalBothButtonCell.id, cellType: TeritaryVerticalBothButtonCell.self)) {
                index, data, cell in
                cell.setData(with: data)
            }
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(inputBox, genderTitleLabel, genderCollectionView)
        
        inputBox.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        genderTitleLabel.snp.makeConstraints {
            $0.top.equalTo(inputBox.snp.bottom).offset(72)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(27)
        }
        
        genderCollectionView.snp.makeConstraints {
            $0.top.equalTo(genderTitleLabel.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(114)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.text = "출생 연도를 알려주세요"
        }
        
        inputBox.do {
            $0.setBirthInput()
        }

        genderTitleLabel.do {
            $0.font = .fontNanum(.H4_Regular)
            $0.textColor = .Black
            $0.textAlignment = .center
            $0.text = "성별을 알려주세요"
        }
        
        genderCollectionView.do {
            $0.backgroundColor = .Side100
            $0.register(TeritaryVerticalBothButtonCell.self, forCellWithReuseIdentifier: TeritaryVerticalBothButtonCell.id)
        }
    }
}

extension OptionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (collectionView.frame.width - 49) / 2
        return CGSize(width: cellwidth, height: 114)
    }
}

