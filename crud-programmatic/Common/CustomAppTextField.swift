//
//  CustomAppTextField.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/28/23.
//

import UIKit

class CustomAppTextField: UITextField {


    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureTextField()
    }
   	 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String, content text: String, keyboardType: UIKeyboardType) {
        self.init(frame: .zero)
        self.placeholder = placeHolder
        self.text = text
        self.keyboardType = keyboardType
    }
    
    private func configureTextField(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 15)
        borderStyle = .line
        autocorrectionType = .no
    }
}

