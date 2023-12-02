//
//  UDM.swift
//  records_app_crud
//
//  Created by DNA-product on 7/19/23.
//

import Foundation

class UDM{

    static let shared = UDM()

    let defaults = UserDefaults()

    lazy private var productList: [Product] = decodeFromUD();

    /// method to add product
    /// accepts product object as parameter
    func addProduct(product: Product){
        productList.insert(product, at: 0)
        saveToLocal(dataList: productList)
    }

    /// method to fetch a list of products
    /// returns an array of products
    func fetchProducts() -> [Product]{
        return productList
    }

    /// method to update product details
    /// accepts ID: Int and product Object as parameter
    func updateProduct(id: Int, updatedProduct: Product){
        if let productIndex = productList.firstIndex(where: { product in product.id == updatedProduct.id }){
            productList[productIndex] = updatedProduct
            saveToLocal(dataList: productList)
        }
    }

    /// method to delete a product
    /// accepts ID: Int as parameter
    func deleteProducts(id: Int){
        if let productIndex = productList.firstIndex(where: { $0.id == id}){
            productList.remove(at: productIndex)
        }
        saveToLocal(dataList: productList)
    }
    
    func saveToLocal(dataList: [Product]?){
        encodeForSaveUD(dataList: dataList!)
        
    }

    private func encodeForSaveUD(dataList: [Product]){
        do{
            let data = try JSONEncoder().encode(dataList)

            defaults.setValue(data, forKey: Constants.productKey)
        } catch {
            print("Unable to encode records (\(error))")
        }
    }

    private func decodeFromUD() -> [Product]{
        if let data = defaults.value(forKey: Constants.productKey){
            do {
                let dataList: [Product] = try JSONDecoder().decode([Product].self, from: data as! Data)
                return dataList
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return [Product]()
    }
    
    internal func encodeProductIdCountForUD(idCount: Int){
        do{
            let data = try JSONEncoder().encode(idCount)
            
            defaults.set(data, forKey: Constants.idKey)
        }catch{
            print("Unable to encode idCount (\(error))")
        }
    }
    
    internal func decodeProductIdCountFromUD() -> Int{
        if let data = defaults.value(forKey: Constants.idKey){
            do{
                let id: Int = try JSONDecoder().decode(Int.self, from: data as! Data)
                return id
            } catch{
                print("Unable to decode idCount (\(error)")
            }
        }
        return 0
    }
    
    
}
