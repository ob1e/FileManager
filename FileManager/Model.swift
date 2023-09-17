//
//  Model.swift
//  FileManager


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
    
    
    
    func addImage(image: UIImage, fileName: String) {
        
        let documentsDirectory = URL(filePath: path + "/" )
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = image.pngData() {
            do {
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
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
