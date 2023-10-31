//
//  RespondingTextField.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 10/31/23.
//

import UIKit

final class RespondingTextField: UITextField {
    private var editingBorderColor: UIColor
    private var editingBorderWidth: CGFloat
    private var placeholderText: String
    
    init(editingBorderColor: UIColor, 
         editingBorderWidth: CGFloat,
         placeholderText: String
    ) {
        self.editingBorderColor = editingBorderColor
        self.editingBorderWidth = editingBorderWidth
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        self.delegate = self
        setBorderLine()
        setStyles()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        let rectWidth = rect.width
        let rectHeight = rect.height
        return CGRect(x: 30, y: 0, width: rectWidth - 30, height: rectHeight)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -20, dy: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RespondingTextField {
    
    private func setStyles() {
        self.backgroundColor = .Side200
        
        textColor = .Black
        attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.Gray4]
        )
        clearButtonMode = .whileEditing
        leftViewMode = .always
        leftView = UIView(frame: .init(x: 0, y: 0, width: 30, height: 30))
        font = .fontNanum(.B1_Regular)
    }
    
    private func setBorderLine() {
        self.layer.borderWidth = editingBorderWidth
        self.layer.masksToBounds = true
        self.cornerRadius = 18
        modifyBorderLine(with: .clear)
    }
    
    private func modifyBorderLine(with color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
}

extension RespondingTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        text = ""
        modifyBorderLine(with: editingBorderColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        modifyBorderLine(with: .clear)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
