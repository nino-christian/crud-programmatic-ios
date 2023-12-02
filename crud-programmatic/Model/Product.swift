//
//  UserModel.swift
//  records_app_crud
//
//  Created by DNA-User on 7/17/23.
//
//
import Foundation

struct Product: Codable{
    var id : Int
    var name: String?
    var price: Float?
    var quantity: Int?
    var created_date: Date?
    var updated_date: Date?
}

