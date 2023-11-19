//
//  CameraViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 18/11/2566 BE.
//

import Foundation

class CameraViewModel: ObservableObject {
    
    var status: Observable<Bool> = Observable(false)
    
    func toggle() {
        self.status.value = true
    }
    
    func reset() {
        self.status.value = false
    }
}
