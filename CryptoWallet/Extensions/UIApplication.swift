//
//  UIApplication.swift
//  CryptoWallet
//
//  Created by ricardo silva on 10/05/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
