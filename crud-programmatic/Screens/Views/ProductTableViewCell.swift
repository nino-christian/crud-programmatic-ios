//
//  ProductTableViewCell.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/24/23.
//

import UIKit

//protocol ProductPopUpDelegate{
//    func showDeletePopUp(id: Int, quantity: Int)
//}

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - VARIABLES
    static let identifier = "ProductTableViewCell"
    var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }
    var product: Product?
    
//    var productPopUpDelegate: ProductPopUpDelegate?
    
    var productNameLabel: UILabel      = UILabel()
    var productPriceLabel: UILabel     = UILabel()
    var productQuantityLabel: UILabel  = UILabel()
//    var productDeleteButton: UIButton  = UIButton()
//    var productDeletePopUpView: UIView = UIView()

    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI CONFIGURATIONS
    private func configureUI(){
        configureProductNameLabel()
        configureProductPriceLabel()
        configureProductQuantityLabel()
//        configureDeleteButton()
    }
    	
    private func configureProductNameLabel(){
        self.contentView.addSubview(productNameLabel)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.text = product?.name ?? "no product name specified"
        productNameLabel.adjustsFontSizeToFitWidth = true
        productNameLabel.textColor = UIColor.label
        productNameLabel.font = UIFont.systemFont(ofSize: 13.5, weight: .semibold)
        
        
        NSLayoutConstraint.activate([
            productNameLabel.widthAnchor.constraint(equalToConstant: 150),
            productNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3),
            productNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
        ])
    }
    
    private func configureProductPriceLabel(){
        self.contentView.addSubview(productPriceLabel)
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.text =  "$ " + (numberFormatter.string(from: NSNumber(value: (product?.price ?? 0.00) )) ?? "0.00")
        productPriceLabel.textColor = .darkGray
        productPriceLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        
        NSLayoutConstraint.activate([
            productPriceLabel.widthAnchor.constraint(equalToConstant: 150),
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            productPriceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
        ])
    }
    
    private func configureProductQuantityLabel(){
        self.contentView.addSubview(productQuantityLabel)
        productQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        productQuantityLabel.text = "\(product?.quantity ?? 0) Pcs."
        productQuantityLabel.font = UIFont.systemFont(ofSize: 12.5, weight: .light)
        
        NSLayoutConstraint.activate([
            productQuantityLabel.widthAnchor.constraint(equalToConstant: 150),
            productQuantityLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 2),
            productQuantityLabel.leadingAnchor.constraint(equalTo: productPriceLabel.leadingAnchor),
            productQuantityLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3)
        ])
    }
    
//    private func configureDeleteButton(){
//        self.contentView.addSubview(productDeleteButton)
//        productDeleteButton.translatesAutoresizingMaskIntoConstraints = false
//        productDeleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
//        productDeleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            productDeleteButton.widthAnchor.constraint(equalToConstant: 60),
//            productDeleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
//            productDeleteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            productDeleteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
//        ])
//    }
    
    // MARK: - OBJC FUNCTIONS
//    @objc func deleteButtonTapped(){
//        productPopUpDelegate?.showDeletePopUp(id: product!.id, quantity: (product?.quantity)!)
//
//    }
    // MARK: - FUNCTIONS
//    func setProductObject(product: Product){
//        self.product = product
//    }
}
