//
//  PasswordDelegate.swift
//  SignUp
//
//  Created by Ador on 2021/03/29.
//

import UIKit

class PasswordFieldDelegate: NSObject, UITextFieldDelegate {
    private var firstResponserHandler: () -> Void
    private let presenter: Presentable
    
    init(presenter: Presentable, handler: @escaping () -> Void) {
        self.presenter = presenter
        self.firstResponserHandler = handler
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.activate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.unActivate()
        guard let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty else {
            presenter.updateLabel(with: PasswordCheck.empty.rawValue, status: false)
            return
        }
        
        FormatManager.validate(password: text) { message, status in
            presenter.updateLabel(with: message, status: status)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstResponserHandler()
        return true
    }
}

enum PasswordCheck: String {
    case notEnoughLength = "8자 이상 16자 이하로 입력해주세요."
    case noUppercase = "영문 대문자를 최소 1자 이상 포함해주세요."
    case noNumber = "숫자를 최소 1자 이상 포함해주세요."
    case noSpecialChar = "특수문자를 최소 1자 이상 포함해주세요."
    case safe = "안전한 비밀번호 입니다."
    case empty = "비밀번호를 입력해주세요."
    case notCorrespond = "비밀번호가 일치하지 않습니다."
    case correspond = "비밀번호가 일치합니다."
}
