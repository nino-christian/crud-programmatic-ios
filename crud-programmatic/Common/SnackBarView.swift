//
//  SnackBarView.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/26/23.
//

import UIKit

class SnackBarView: UIView {

    let snackBarViewModel: SnackBarModel
    
    private let snackBarText: UILabel = UILabel()
    
    init(snackBarViewModel: SnackBarModel, frame: CGRect, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat){
        self.snackBarViewModel = snackBarViewModel
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.masksToBounds = true
        self.backgroundColor = .black.withAlphaComponent(0.7)
        configureUIs()
        showSnackBar(width: width, height: height, x: x, y: y)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        snackBarText.frame = CGRect(x: 15, y: 0, width: bounds.width, height: bounds.height / 1.1)
    }
    
    private func configureUIs(){
       
        
        configureSnackBarText()
    }
    
    private func configureSnackBarText(){
        addSubview(snackBarText)
        snackBarText.text = snackBarViewModel.text
        snackBarText.textColor = .white
        snackBarText.font = UIFont.systemFont(ofSize: 14)
        snackBarText.translatesAutoresizingMaskIntoConstraints = true
//
//        NSLayoutConstraint.activate([
//            snackBarText.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//            snackBarText.leadingAnchor.constraint(equalTo: self.leadingAnchor)
//        ])
        
    }
    private func showSnackBar(width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat){
        self.frame = CGRect(x: x,
                                y: y,
                                width: width,
                                height: height)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: x,
                                    y: y + 70,
                                    width: width,
                                    height: height)
        }, completion: { doneAnimate in
            if doneAnimate {
                DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.frame = CGRect(x: x,
                                                y: y,
                                                width: width,
                                                height: height)
                    }, completion: { doneAnimate in
                        if doneAnimate {
                            self.removeFromSuperview()
                        }
                    })
                })
            }
        })
    }
    
}
