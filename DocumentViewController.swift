//
//  DocumentViewController.swift
//  UrgiDoctor
//
//  Created by Yuvraj Bharat Kale on 10/12/20.
//

import UIKit
import MobileCoreServices

protocol DocPickerProtocol {
    func pickerDocument(pickedDoc urls:[URL])
    func pickerCancelled()
}
protocol documentPickerProtocol {
    func selectDocument()
}
class DocumentViewController: UIViewController,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,documentPickerProtocol {
    var docDelegate : DocPickerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        docDelegate?.pickerDocument(pickedDoc: urls)
        print("import result : \(myURL)")
    }
          

    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        docDelegate?.pickerCancelled()
        dismiss(animated: true, completion: nil)
    }

    func selectDocument(){

    let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
