//
//  AddUserRecordVC.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/24/23.
//

import UIKit


protocol ProductDataListDelegate{
    func addNewProduct(product: Product)
}

class AddProductsVC: UIViewController {

    // MARK: ---------------------------------------------------- VARIABLES -----------------------------------------------------
    var productName: String!
    var productPrice: Float!
    var productQuantity: Int!
    
    var productDataListDelegate: ProductDataListDelegate?
    
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
    
    // MARK: ----------------------------------------------------- LIFECYCLE -----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Product"
        view.backgroundColor = .systemBackground
        configureProductFormUIs()
    }
    
    // MARK: ----------------------------------------------------- UI CONFIGURATIONS -----------------------------------------------------
    private func configureProductFormUIs(){
        configureProductNameField()
        configureProductPriceField()
        configureProductQuantityField()
        configureProductSubmitButton()
    }
    
    // Product Name Field
    private func configureProductNameField(){
        productNameLabel = CustomAppProductLabel(text: "Name")
        self.view.addSubview(productNameLabel)
    
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            productNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            productNameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        productNameTextField = CustomAppTextField(placeHolder: "Enter Product Here (Required)",
                                                  content: "",
                                                  keyboardType: .default)
        self.view.addSubview(productNameTextField)
        productNameTextField.addTarget(self, action: #selector(submitButtonStatus), for: .editingChanged)

        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            productNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
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
    
    // Product price field
    private func configureProductPriceField(){
        
        productPriceLabel = CustomAppProductLabel(text: "Price")
        self.view.addSubview(productPriceLabel)
       
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameValidator.bottomAnchor, constant: 20),
            productPriceLabel.leadingAnchor.constraint(equalTo: productNameTextField.leadingAnchor),
            productPriceLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        productPriceTextField = CustomAppTextField(placeHolder: "Enter Price Here (Required)",
                                                   content: "",
                                                   keyboardType: .decimalPad)
        self.view.addSubview(productPriceTextField)
        productPriceTextField.addTarget(self, action: #selector(submitButtonStatus), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            productPriceTextField.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 10),
            productPriceTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            productPriceTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
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
    
    // Product quantity field
    private func configureProductQuantityField(){
        productQuantityLabel = CustomAppProductLabel(text: "Quantity")
        self.view.addSubview(productQuantityLabel)
        
        NSLayoutConstraint.activate([
            productQuantityLabel.topAnchor.constraint(equalTo: productPriceValidator.bottomAnchor, constant: 20),
            productQuantityLabel.leadingAnchor.constraint(equalTo: productPriceTextField.leadingAnchor),
            productQuantityLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        productQuantityTextField = CustomAppTextField(placeHolder: "Enter Quantity Here (Required)", content: "", keyboardType: .decimalPad)
        self.view.addSubview(productQuantityTextField)
        productQuantityTextField.addTarget(self, action: #selector(submitButtonStatus), for: .editingChanged)

        NSLayoutConstraint.activate([
            productQuantityTextField.topAnchor.constraint(equalTo: productQuantityLabel.bottomAnchor, constant: 10),
            productQuantityTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            productQuantityTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
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
    
    
    private func configureProductSubmitButton(){
        self.view.addSubview(productSubmitButton)
        productSubmitButton.translatesAutoresizingMaskIntoConstraints = false
        productSubmitButton.setTitle("Add", for: .normal)
        productSubmitButton.layer.cornerRadius = 8
        productSubmitButton.isEnabled = submitButtonStatus()
        productSubmitButton.backgroundColor = submitButtonStatus() ? .blue : .gray
        productSubmitButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            productSubmitButton.heightAnchor.constraint(equalToConstant: 45),
            productSubmitButton.topAnchor.constraint(equalTo: productQuantityValidator.bottomAnchor, constant: 30),
            productSubmitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            productSubmitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
    // MARK: ----------------------------------------------------- OBJC FUNCTIONS -----------------------------------------------------
    @objc func addButtonTapped(){
        let newProduct: Product = Product(id: generateId(),
                                          name: productName,
                                          price: productPrice,
                                          quantity: productQuantity,
                                          created_date: getTime(),
                                          updated_date: getTime())
        productDataListDelegate?.addNewProduct(product: newProduct)
        navigationController?.popViewController(animated: true)
//        ProgressHUD.colorBackground = .black.withAlphaComponent(0.7)
//        ProgressHUD.show("Adding...")
//        ProgressHUD.animationType = .circleSpinFade
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self]  in
//            ProgressHUD.showSucceed(delay: 0.5)
//
//        }
    }
    
    @objc func submitButtonStatus() -> Bool{
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
    
    // MARK: ---------------------------------------------------- FUNCTIONS ----------------------------------------------------
    private func generateId() -> Int{
        let idCount: Int = UDM.shared.decodeProductIdCountFromUD()
        let newIdCount = idCount + 1
        UDM.shared.encodeProductIdCountForUD(idCount: newIdCount)
        return newIdCount
    }
    private func getTime() -> Date {
        return Date.now
    }
    
    private func validateNameField() -> Bool{
        if let name = productNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines){
            if(name.isEmpty || name == " "){
                productNameValidator.text = "Invalid name"
                productNameValidator.isHidden = false
                return false
            } else {
                let allowedCharacters = CharacterSet.letters.union(.whitespaces)
                let charactersSet = CharacterSet(charactersIn: name)
                if allowedCharacters.isSuperset(of: charactersSet){
                    productNameValidator.text = "Valid name"
                    productNameValidator.isHidden = false
                    self.productName = name
                    return true
                } else {
                    productNameValidator.text = "Invalid name"
                    productNameValidator.isHidden = false
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
                        self.productPrice = 0
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

//MARK: ----------------------------------------------------- EXTENSIONS -----------------------------------------------------
extension AddProductsVC: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == productQuantityValidator
//    }

}
