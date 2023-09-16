//
//  TextPicker.swift
//  FileManager
//
//  Created by JaY on 31.08.2023.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    func showMessage(in viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOK)
        viewController.present(alert, animated: true)
    }
    
    func showPicker(in viewController: UIViewController, withTitle title: String, complition: @escaping (_ text: String)->Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        let actionOK = UIAlertAction(title: "Add", style: .default) { action in
            if let text =  alert.textFields?[0].text {
                complition(text)
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        viewController.present(alert, animated: true)
    }
    
    func showPicker(in viewController: UIViewController, withTitle title: String, complition: @escaping (_ text1: String, _ text2: String)->Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter filename"
        }
        alert.addTextField { textField in
            textField.placeholder = "Enter file content"
        }
        let actionOK = UIAlertAction(title: "Add", style: .default) { action in
            if let text1 =  alert.textFields?[0].text, let text2 = alert.textFields?[1].text {
                complition(text1, text2)
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        viewController.present(alert, animated: true)
    }
}
