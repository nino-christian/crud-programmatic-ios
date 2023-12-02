//
//  CustomAppAlertConroller.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/26/23.
//

import UIKit

class CustomAppAlertConroller: UIViewController {

    private lazy var containerView: UIView = UIView()
    private var leftButton: UIButton = UIButton()
    
//    var alertTitle: String
//    var alertMessage: String
//    var leftButtonTitle: String
//    var rightButtonTitle: String
//    var completionLeftButton: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        // Do any additional setup after loading the view.
        configureUIs()
    }
    
    // MARK: - UI CONFIGURATION
    private func configureUIs(){
        configureContentView()
        configureLeftButton()
    }
    private func configureContentView(){
    self.view.addSubview(containerView)
        containerView.backgroundColor = .systemMint
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.5),
            containerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.14),
                                                  
        ])
    }
    private func configureLeftButton(){
        containerView.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.backgroundColor = .white
        leftButton.setTitle("Cancel", for: .normal)
        leftButton.setTitleColor(.blue , for: .normal)
        leftButton.layer.cornerRadius = 8
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftButton.centerXAnchor.constraint(equalTo:containerView.centerXAnchor),
            leftButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 100),
            leftButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func leftButtonAction(){
        self.dismiss(animated: true)
    }
    func leftButtonTapped(){}
    func rightButtonTapped(){}
}
