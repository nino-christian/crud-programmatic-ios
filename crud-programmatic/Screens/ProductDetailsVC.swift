//
//  ProductDetailsVC.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/25/23.
//

import UIKit


class ProductDetailsVC: UIViewController {
    
    // MARK: ---------------------------------------------------- VARIABLES ---------------------------------------------------------
    var product: Product!
    
    var productName: String!
    var productPrice: Float!
    var productQuantity: Int!
    
    private var productNameLabel: CustomAppProductLabel!
    private var productNameTextField: CustomAppTextField!
    private var productNameValidator: CustomValidatorLabel!
    
    private var productPriceLabel: CustomAppProductLabel!
    private var productPriceTextField: CustomAppTextField!
    private var productPriceValidator: CustomValidatorLabel!
    
    private var productQuantityLabel: CustomAppProductLabel!
    private var productQuantityTextField: CustomAppTextField!
    private var productQuantityValidator: CustomValidatorLabel!
    
    private var productSubmitButton: UIButton = UIButton()
    
    // MARK: ---------------------------------------------------- LIFECYCLE ---------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Update Product"
        // Do any additional setup after loading the view.
        
        configureProductFormUIs()
    }
    

    // MARK: -------------------------------------------------- UI CONFIGURATIONS -----------------------------------------------------
    private func configureProductFormUIs(){
        configureProductNameField()
        configureProductPriceField()
        configureProductQuantityField()
        configureProductUpdateButton()
    }
    private func configureProductNameField(){
        productNameLabel = CustomAppProductLabel(text: "Name")
        self.view.addSubview(productNameLabel)
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            productNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            productNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
        
        productNameTextField = CustomAppTextField(placeHolder: "Enter Product Here (Required)",
                                                  content: product.name ?? "Not specified",
                                                  keyboardType: .default)
        self.view.addSubview(productNameTextField)
        productNameTextField.addTarget(self, action: #selector(updateButtonStatus), for: .editingChanged)
        

        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productNameTextField.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productNameTextField.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            productNameTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        productNameValidator = CustomValidatorLabel()
        self.view.addSubview(productNameValidator)

        NSLayoutConstraint.activate([
            productNameValidator.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 5),
            productNameValidator.leadingAnchor.constraint(equalTo: productNameTextField.leadingAnchor),
            productNameValidator.trailingAnchor.constraint(equalTo: productNameTextField.trailingAnchor)
        ])
    }
    private func configureProductPriceField(){
        productPriceLabel = CustomAppProductLabel(text: "Price")
        self.view.addSubview(productPriceLabel)
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameValidator.bottomAnchor, constant: 25),
            productPriceLabel.leadingAnchor.constraint(equalTo: productNameTextField.leadingAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: productNameTextField.trailingAnchor)
        ])
        
        productPriceTextField = CustomAppTextField(placeHolder: "Enter Price Here (Required)",
                                                   content: String(format: "%.2f", product.price ?? 0.00),
                                                   keyboardType: .decimalPad)
        self.view.addSubview(productPriceTextField)
        productPriceTextField.addTarget(self, action: #selector(updateButtonStatus), for: .editingChanged)
        
        
        NSLayoutConstraint.activate([
            productPriceTextField.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 10),
            productPriceTextField.leadingAnchor.constraint(equalTo: productPriceLabel.leadingAnchor),
            productPriceTextField.trailingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor),
            productPriceTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        productPriceValidator = CustomValidatorLabel()
        self.view.addSubview(productPriceValidator)
        
        NSLayoutConstraint.activate([
            productPriceValidator.topAnchor.constraint(equalTo: productPriceTextField.bottomAnchor, constant: 5),
            productPriceValidator.leadingAnchor.constraint(equalTo: productPriceTextField.leadingAnchor),
            productPriceValidator.trailingAnchor.constraint(equalTo: productPriceTextField.trailingAnchor)
        ])
    }
    private func configureProductQuantityField(){
        productQuantityLabel = CustomAppProductLabel(text: "Quantity")
        self.view.addSubview(productQuantityLabel)
        
        NSLayoutConstraint.activate([
            productQuantityLabel.topAnchor.constraint(equalTo: productPriceValidator.bottomAnchor, constant: 25),
            productQuantityLabel.leadingAnchor.constraint(equalTo: productPriceTextField.leadingAnchor),
            productQuantityLabel.trailingAnchor.constraint(equalTo: productPriceTextField.trailingAnchor)
        ])
        
        productQuantityTextField = CustomAppTextField(placeHolder: "Enter Quantity Here (Required)",
                                                      content: "\(product.quantity ?? 0)",
                                                      keyboardType: .decimalPad)
        self.view.addSubview(productQuantityTextField)
        productQuantityTextField.addTarget(self, action: #selector(updateButtonStatus), for: .editingChanged)
       
        NSLayoutConstraint.activate([
            productQuantityTextField.topAnchor.constraint(equalTo: productQuantityLabel.bottomAnchor, constant: 10),
            productQuantityTextField.leadingAnchor.constraint(equalTo: productQuantityLabel.leadingAnchor),
            productQuantityTextField.trailingAnchor.constraint(equalTo: productQuantityLabel.trailingAnchor),
            productQuantityTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        productQuantityValidator = CustomValidatorLabel()
        self.view.addSubview(productQuantityValidator)
        
        NSLayoutConstraint.activate([
            productQuantityValidator.topAnchor.constraint(equalTo: productQuantityTextField.bottomAnchor, constant: 5),
            productQuantityValidator.leadingAnchor.constraint(equalTo: productQuantityTextField.leadingAnchor),
            productQuantityValidator.trailingAnchor.constraint(equalTo: productQuantityTextField.trailingAnchor)
        ])
    }
    private func configureProductUpdateButton(){
        self.view.addSubview(productSubmitButton)
        productSubmitButton.translatesAutoresizingMaskIntoConstraints = false
        productSubmitButton.setTitle("Update", for: .normal)
        productSubmitButton.layer.cornerRadius = 8
        productSubmitButton.tintColor = .white
        productSubmitButton.isEnabled = updateButtonStatus()
        productSubmitButton.backgroundColor = updateButtonStatus() ? .blue : .gray
        productSubmitButton.addTarget(self, action: #selector(updateProduct), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            productSubmitButton.heightAnchor.constraint(equalToConstant: 45),
            productSubmitButton.topAnchor.constraint(equalTo: productQuantityValidator.bottomAnchor, constant: 30),
            productSubmitButton.leadingAnchor.constraint(equalTo: productQuantityTextField.leadingAnchor),
            productSubmitButton.trailingAnchor.constraint(equalTo: productQuantityTextField.trailingAnchor)
        ])
    }
    
    // MARK: ----------------------------------------------------- OBJC FUNCTIONS -----------------------------------------------------
    @objc func updateProduct(){
        let alert = UIAlertController(title: "Update Product", message: "Save changes?", preferredStyle: .alert)
        
        let saveAlertAction = UIAlertAction(title: "Save",style: .default, handler: { [self] _ in
            let updatedProduct: Product = Product(id: product.id,
                                                  name: productNameTextField.text,
                                                  price: Float(productPriceTextField.text ?? "0.0"),
                                                  quantity: Int(productQuantityTextField.text ?? "0"),
                                                  created_date: product.created_date,
                                                  updated_date: Date.now)
            UDM.shared.updateProduct(id: product.id, updatedProduct: updatedProduct)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadNotification"), object: nil)
            navigationController?.popViewController(animated: true)
        })
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            print("cancel button pressed")
        })
        
        saveAlertAction.setValue(UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1), forKey: "titleTextColor")
        alert.addAction(saveAlertAction)
        alert.addAction(cancelAlertAction)
        self.present(alert, animated: true)
    }
    
    @objc func updateButtonStatus() -> Bool{
        let validName: Bool = validateNameField()
        let validPrice: Bool = validatePriceField()
        let validQuantity: Bool = validateQuantityfield()
        
       
        if(validName && validPrice && validQuantity){
            productSubmitButton.isEnabled = true
            productSubmitButton.backgroundColor = .blue
            return true
        } else {
            productSubmitButton.isEnabled = false
            productSubmitButton.backgroundColor = .gray
            return false
        }
    }
    
    // MARK: ------------------------------------------------------ FUNCTIONS ------------------------------------------------------------
    private func validateNameField() -> Bool{
        if let name = productNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines){
            if(name.isEmpty || name == " "){
                productNameValidator.text = "invalid name"
                productNameValidator.isHidden = false
                return false
            } else {
                let allowedCharacters = CharacterSet.letters.union(.whitespaces)
                let charactersSet = CharacterSet(charactersIn: name)
                if allowedCharacters.isSuperset(of: charactersSet){
                    productNameValidator.text = "valid name"
                    self.productName = name
                    return true
                } else {
                    productNameValidator.text = "invalid name"

                    return false
                }
            }
        } else {
            return false
        }
    }
    
    private func validatePriceField() -> Bool{
        if let price = productPriceTextField.text{
            if(price.isEmpty || price == " "){
                productPriceValidator.text = "Invalid price"
                productPriceValidator.isHidden = false
                return false
            } else {
                let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
                let characterSet = CharacterSet(charactersIn: price)
                if allowedCharacters.isSuperset(of: characterSet){
                    guard let floatPrice = Float(price) else {
                        productPriceValidator.text = ("Number contains only 1 point")
                        return false
                    }
                    if floatPrice < 0 {
                        productPriceValidator.text = "Price cannot be negative"
                        return false
                    } else if floatPrice == 0 {
                        productPriceValidator.text = "Price will be free"
                        return true
                    } else {
                        productPriceValidator.text = "Valid price"
                        self.productPrice = floatPrice
                        return true
                    }
                } else {
                    productPriceValidator.text = "Invalid price"
                    return false
                }
            }
        } else {
            return false
        }
    }
    
    private func validateQuantityfield() -> Bool {
        if let productQuantity = productQuantityTextField.text {
            if(productQuantity.isEmpty) || (productQuantity.contains(".")){
                productQuantityValidator.text = "Invalid quantity"
                productQuantityValidator.isHidden = false
                return false
            } else {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: productQuantity)
                if allowedCharacters.isSuperset(of: characterSet){
                    productQuantityValidator.text = "Valid quantity"
                    self.productQuantity = Int(productQuantity)
                    return true
                } else {
                    productQuantityValidator.text = "Invalid quantity"
                   
                    return false
                }
            }
        } else {
            return false
        }
    }
    
   
}
