//
//  Model.swift
//  FileManager
//
//
//

import Foundation
import UIKit

class Model {
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    var title: String {
        return NSString(string: path).lastPathComponent
    }
    
    var items: [String] {
        return (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }
    
    func addFolder(name: String) {
       try? FileManager.default.createDirectory(atPath: path + "/" + name, withIntermediateDirectories: true)
    }
    
    func addFile(name: String, content: String) {
        let url = URL(filePath: path + "/" + name)
        try? content.data(using: .utf8)?.write(to: url)
    }
    
    func addImage(imageName: String, image: UIImage) {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let data  = image.jpegData(compressionQuality: 0.5)
        let fileName = imageName
        let fileURL = directory.appending(path: fileName)
        try? data!.write(to: fileURL)
        
    }
    
    
    func saveImageLocally(image: UIImage, fileName: String) {
        
     // Obtaining the Location of the Documents Directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let urls = URL(filePath: path + "/" )
        // Creating a URL to the name of your file
        let url = urls.appendingPathComponent(fileName)
        
        if let data = image.pngData() {
            do {
                try data.write(to: url) // Writing an Image in the Documents Directory
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(image).png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func fullPathForItem(index: Int) -> String {
        path + "/" + items[index]
    }
    
    func isPathForItemIndexIsFolder(index: Int) -> Bool {
        var objCBool: ObjCBool = .init(false)
        FileManager.default.fileExists(atPath: fullPathForItem(index: index), isDirectory: &objCBool)
        if objCBool.boolValue {
            return true
        } else {
            return false
        }
    }
    
    func deleteItem(withIndex index: Int) {
        let pathForDelete = path + "/" + items[index]
        try? FileManager.default.removeItem(atPath: pathForDelete)
    }
}

/*
 func saveImageLocally(image: UIImage, fileName: String) {
     
  // Obtaining the Location of the Documents Directory
     let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     
     // Creating a URL to the name of your file
     let url = documentsDirectory.appendingPathComponent(fileName)
     
     if let data = image.pngData() {
         do {
             try data.write(to: url) // Writing an Image in the Documents Directory
         } catch {
             print("Unable to Write \(fileName) Image Data to Disk")
         }
     }
 }*/
