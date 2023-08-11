//
//  GetGenderViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetOptionViewController: UIViewController {
    @IBOutlet weak var nextButton: SecondaryIconButton!
    @IBOutlet weak var prevButton: SecondaryIconButton!
    @IBOutlet weak var input: Input!
    let viewModel = GetOptionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.setImage(image: "ArrowLeft")
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
        input.setInputKeyobardStyle()
        input.inputBox.delegate = self
    }

    func checkYear() {
        guard input.getText() != nil else {
            self.showToast(message: "다시 시도해주세요.")
            return
        }

        if let text = input.getText(),
           let year = Int(text) {
            if year >= viewModel.todayYear - 100 {
                if year > viewModel.todayYear || year < 999 {
                    self.showToast(message: "형식에 맞지 않습니다.")
                } else {
                    viewModel.year = text
                    self.isAllChecked()
                }
            } else {
                self.showToast(message: "\(viewModel.todayYear - 100)년 이상부터 입력이 가능합니다.")
            }
        }
    }

    func isAllChecked() {
        if viewModel.year != nil && viewModel.gender != nil {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.input.hiddenKeyboard()
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPage()
        if let gender = viewModel.gender,
           let year = viewModel.year {
            SignUpData.shared.gender = gender
            SignUpData.shared.birthDate = year
        }
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
    }
}

extension GetOptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeritaryVerticalBothButtonCell.id, for: indexPath) as? TeritaryVerticalBothButtonCell else { return UICollectionViewCell() }
        cell.setData(with: viewModel.genderList[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 103, height: 114)
   }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.gender = "male"
        } else {
            viewModel.gender = "female"
        }
        isAllChecked()
    }
}

extension GetOptionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        guard let text = textField.text else { return false }
        if isBackSpace == -92 || text.count <= 3 {
            return true
        } else {
            input.hiddenKeyboard()
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        checkYear()
    }
}
