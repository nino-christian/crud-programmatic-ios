//
//  ViewController.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/24/23.
//

import UIKit


class ProductsHomeVC: UIViewController, ProductDataListDelegate{
    
   
    // MARK: -------------------------------------------------------- VARIABLES --------------------------------------------------------------
    private let ProductSearchController: UISearchController = UISearchController()
    private let productSearchBarContainer: UIView           = UIView()
    private let productTableView: UITableView               = UITableView()
    private let addProductFloatingButton: UIButton          = UIButton()
    
    var productList : Observer<[Product]> = Observer(value: [Product]())
    
    var finalProducts: [Product] = []
    
    private let tableViews = UITableView()
    
    // MARK: -------------------------------------------------------- LIFESCYCLE --------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        finalProducts = UDM.shared.fetchProducts()
//        print(finalProducts)
        productList.value = finalProducts
        view.backgroundColor = .systemBackground
        self.title = "Products"
        // Do any additional setup after loading the view.
        configureUIs()
        
        productList.update { [weak self] dataList in
            DispatchQueue.main.async {
                guard let this = self else {
                    return
                }
                UDM.shared.saveToLocal(dataList: this.finalProducts)
                this.productTableView.reloadData()
            }
        }
    }
    
    // MARK: -------------------------------------------------------- UI CONFIGURATION --------------------------------------------------------------
    private func configureUIs(){
        configureProductSearchController()
        configureProductTableView()
        configureRightBottomFloatingButton()
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(recordTableReload),
                                               name: NSNotification.Name(rawValue: "reloadNotification"),
                                               object: nil)
    }
    private func configureProductSearchController(){
    
        navigationItem.searchController = ProductSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        ProductSearchController.searchBar.placeholder = "Search Product..."
        ProductSearchController.searchResultsUpdater = self
        
        
    }
    private func configureProductTableView(){
        self.view.addSubview(productTableView)
        productTableView.delegate = self
        productTableView.dataSource = self

        productTableView.backgroundColor = .systemBackground
        productTableView.estimatedRowHeight = 80

        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        productTableView.allowsSelection = true
        productTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            productTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            productTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            productTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func configureRightBottomFloatingButton(){
        self.view.addSubview(addProductFloatingButton)
        addProductFloatingButton.imageView?.contentMode = .scaleAspectFit
        addProductFloatingButton.setImage(UIImage(named: Assets.plusSVG), for: .normal)
        addProductFloatingButton.setTitle(nil, for: .normal)
        addProductFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        addProductFloatingButton.layer.cornerRadius = 25
        addProductFloatingButton.addTarget(self, action: #selector(pushAddProductVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addProductFloatingButton.widthAnchor.constraint(equalToConstant: 50),
            addProductFloatingButton.heightAnchor.constraint(equalToConstant: 50),
            addProductFloatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addProductFloatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        
    }
    // MARK: - OBJC FUNCTIONS
    /// NAVIGATE TO ADD PRODUCT SCREEN
    @objc func pushAddProductVC(){
        let addProductVC = AddProductsVC()
        addProductVC.modalPresentationStyle = .fullScreen
        addProductVC.productDataListDelegate  = self
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
    
    /// NOFICATION OBSERVER FUNCTION FOR PRODUCT TABLE RELOAD
    @objc func recordTableReload(){
        DispatchQueue.main.async {
            self.productList.value = UDM.shared.fetchProducts()
            self.finalProducts = UDM.shared.fetchProducts()
            self.productTableView.reloadData()
        }
    }
    
    // MARK: ------------------------------------------------------- FUNCTIONS -------------------------------------------------------------------
    /// ProductPopUpDelegate FUNCTION
    private func showSnackBar(){
        let snackBarModel: SnackBarModel
        snackBarModel = SnackBarModel(text: "Cannot delete products with stocks")
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.2, height: 44)
        let width = view.frame.size.width/1.2
        let posX = (view.frame.size.width - width) / 2
        let posY = 0.0
        let height = CGFloat(44)
        let snackBar = SnackBarView(snackBarViewModel: snackBarModel,
                                    frame: frame,
                                    width: width,
                                    height: height,
                                    x: posX,
                                    y: posY)
        view.addSubview(snackBar)

    }
    /// ProductDataListDelegate FUNCTION
    func addNewProduct(product: Product) {
        productList.value?.insert(product, at: 0)
        finalProducts.insert(product, at: 0)
        UDM.shared.addProduct(product: product)
        
    }
}

// MARK: ------------------------------------------------------- EXTENSIONS -------------------------------------------------------------------
extension ProductsHomeVC: UITableViewDelegate, UITableViewDataSource {
    /// PRODUCT TABLE VIEW CONFIGURATION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.value?.count ?? 0
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell {
            guard let product = productList.value?[indexPath.row] else {
                return cell
            }
//            cell.productPopUpDelegate = self
//            cell.setProductObject(product: product)
            cell.selectionStyle = .none
            cell.productNameLabel.text = product.name ?? "Not Specified"
            cell.productPriceLabel.text = (product.price == 0) ? "Free" : "$ " + String(format: "%.2f", product.price ?? 0.00)
            cell.productQuantityLabel.text = "\(product.quantity ?? 0) Pcs."
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = productList.value?[indexPath.row] else {
            return
        }
        let productDetailsVC = ProductDetailsVC()
        productDetailsVC.modalPresentationStyle = .fullScreen
        productDetailsVC.product = product
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            productTableView.beginUpdates()
            guard let product = productList.value?[indexPath.row] else {
                return
            }
            if product.quantity == 0{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Delete Product", message: "This action is permanent. Do you want to continue?", preferredStyle: .alert)
                    let deleteAlertAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self]  _ in
                        UDM.shared.deleteProducts(id: product.id)
    
                        self?.productList.value?.remove(at: indexPath.row)
                        self?.finalProducts.remove(at: indexPath.row)
                        self?.productTableView.deleteRows(at: [indexPath], with: .fade)
                        
                        print("deleted product")
                        
                        print(UDM.shared.fetchProducts())
                    })
                    let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: {  _ in
                        print("button pressed")
                    })
                    deleteAlertAction.setValue(UIColor.red, forKey: "titleTextColor")
                    alert.addAction(deleteAlertAction)
                    alert.addAction(cancelAlertAction)
                    self.present(alert, animated: true)
                }
                
            } else {
                showSnackBar()
            }
            productTableView.endUpdates()
        }
    }

}
extension ProductsHomeVC: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchInput = searchController.searchBar.text
        if searchInput == ""{
            
            let dataList = finalProducts
            productList.value = dataList
        } else {
            let dataList = UDM.shared.fetchProducts()
            productList.value = dataList.filter{ product in
                product.name!.lowercased().contains(searchInput!.lowercased())
            }.sorted(by: { $0.name!.lowercased() < $1.name!.lowercased()})
        }
        productTableView.reloadData()
    }

}



