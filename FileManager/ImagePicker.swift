//
//  ImagePicker.swift
//  FileManager
//
//
//

import UIKit


class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let defaultPicker = ImagePicker()
    
    var picker: UIImagePickerController!
    
    private var completion: ((_ imageData: UIImage) -> Void)?
    
    func showPicker(in  viewController: UIViewController, completion: (( _ imageData: UIImage)-> Void)? ) {
        
        self.completion = completion
        
        picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        viewController.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageData = (info[.originalImage] as? UIImage)/*?.jpegData(compressionQuality: 0.5)*/ {
            completion?(imageData)
            picker.dismiss(animated: true)
        }
    }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
