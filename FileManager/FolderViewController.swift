//
//  FolderViewController.swift
//  FileManager
//

import UIKit

class FolderViewController: UITableViewController, UINavigationControllerDelegate {
    
    static func showFolderController(in navigationController: UINavigationController?, withPath path: String) {
        let fc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "folderControllerSID") as! FolderViewController
        let model = Model(path: path)
        fc.model = model
        navigationController?.pushViewController(fc, animated: true)
        
    }
    
    var model = Model(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = model.title
        
    }
    
    @IBAction func createFolderAction(_ sender: Any) {
        TextPicker.defaultPicker.showPicker(in: self, withTitle: "Add folder") { text in
            self.model.addFolder(name: text)
            self.tableView.reloadData()
        }
        
    }
    @IBAction func createFileAction(_ sender: Any) {
        TextPicker.defaultPicker.showPicker(in: self, withTitle: "Add file") { text1, text2 in
            self.model.addFile(name: text1, content: text2)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        TextPicker.defaultPicker.showPicker(in: self, withTitle: "Add photo") { text in
            ImagePicker.defaultPicker.showPicker(in: self) { [weak self] imageData in
                self?.model.addImage(image: imageData, fileName: text + ".png")
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = model.items[indexPath.row]
        
        if model.isPathForItemIndexIsFolder(index: indexPath.row) {
            configuration.secondaryText = "FOLDER"
            cell.accessoryType = .disclosureIndicator
        } else {
            configuration.secondaryText = "File"
            cell.accessoryType = .none
        }
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if model.isPathForItemIndexIsFolder(index: indexPath.row) {
            FolderViewController.showFolderController(in: navigationController, withPath: model.fullPathForItem(index: indexPath.row))
        }
        else {
            let string = try? NSString(contentsOf: URL(filePath: model.fullPathForItem(index: indexPath.row)), encoding: NSUTF8StringEncoding)
            TextPicker.defaultPicker.showMessage(in: self, title: "File content", message: string as? String ?? "")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteItem(withIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }    
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
