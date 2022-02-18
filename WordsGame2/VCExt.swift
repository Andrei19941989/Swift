//
//  VCExt.swift
//  WordsGame2
//

//

import UIKit

extension UIViewController {
    
    func presentAlert(_ message: String) {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ОК, понял...", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}
