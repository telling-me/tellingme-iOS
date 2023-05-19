//
//  Input.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation
import UIKit

class Input: UIView {
    var inputBox: UITextField = {
       let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.borderStyle = .none
        input.textColor = UIColor(named: "Black")
        input.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        input.backgroundColor = .clear
        input.clearButtonMode = .whileEditing
        return input
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "Side200")
        self.cornerRadius = 18
        addSubview(inputBox)
        inputBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        inputBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        inputBox.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        inputBox.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }

    func setDisalbe() {
        self.backgroundColor = UIColor(named: "Gray1")
        self.inputBox.text = nil
        inputBox.isUserInteractionEnabled = false
        inputBox.placeholder = "기타 선택 후 입력"
    }
    
    func setAble() {
        self.backgroundColor = UIColor(named: "Side200")
        self.inputBox.placeholder = "직접 입력"
        inputBox.isUserInteractionEnabled = true
    }
    
    func hiddenKeyboard() {
        self.inputBox.resignFirstResponder()
    }
}
