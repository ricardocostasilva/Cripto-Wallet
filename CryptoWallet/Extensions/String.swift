//
//  String.swift
//  CryptoWallet
//
//  Created by ricardo silva on 13/05/2022.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
