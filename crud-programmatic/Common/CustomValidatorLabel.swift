//
//  CustomValidatorLabel.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/31/23.
//

import UIKit

class CustomValidatorLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .red
        font = UIFont.systemFont(ofSize: 13)
        isHidden = true
        text = "Required"
    }

}
