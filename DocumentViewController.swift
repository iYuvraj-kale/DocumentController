import UIKit
import MobileCoreServices

protocol DocPickerProtocol {
    func pickerDocument(pickedDoc urls:[URL])
    func pickerCancelled()
}
protocol DocumentPickerProtocol {
    func selectDocument()
}
class DocumentViewController: UIViewController,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,DocumentPickerProtocol {
    var docDelegate : DocPickerProtocol?
    var docPickerDelegate : DocumentPickerProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
//        docPickerDelegate = self
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
        DocumentViewController.topMostViewController2()?.present(documentPicker, animated: true, completion: nil)
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
//        self.present(importMenu, animated: true, completion: nil)
        DocumentViewController.topMostViewController2()?.present(importMenu, animated: true, completion: nil)
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
extension UIViewController {
   static func topMostViewController2() -> UIViewController? {
       if #available(iOS 13.0, *) {
           let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
           return keyWindow?.rootViewController?.topMostViewController1()
       }

       return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController1()
   }

   func topMostViewController1() -> UIViewController? {
       if let navigationController = self as? UINavigationController {
           return navigationController.topViewController?.topMostViewController1()
       }
       else if let tabBarController = self as? UITabBarController {
           if let selectedViewController = tabBarController.selectedViewController {
               return selectedViewController.topMostViewController1()
           }
           return tabBarController.topMostViewController1()
       }

       else if let presentedViewController = self.presentedViewController {
           return presentedViewController.topMostViewController1()
       }

       else {
           return self
       }
   }
}
