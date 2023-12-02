//
//  CustomAppProductLabel.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/31/23.
//

import UIKit

class CustomAppProductLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    private func configureLabel(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
    }

}
