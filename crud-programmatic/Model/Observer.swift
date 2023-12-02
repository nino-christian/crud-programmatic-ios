//
//  Observer.swift
//  cud-user-app-programmatic
//
//  Created by DNA-User on 7/24/23.
//

import Foundation

class Observer<T> {
    var value: T? {
        didSet {
        observerBlock?(value)
        }
    }
    
    init(value: T? = nil) {
        self.value = value
    }
    
    private var observerBlock: ((T?) -> Void)?
    
    func update(_ observer: @escaping (T?) -> Void) {
        self.observerBlock = observer
    }
}
