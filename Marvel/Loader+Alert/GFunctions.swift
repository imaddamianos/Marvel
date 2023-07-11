//
//  GFunctions.swift
//  Marvel
//
//  Created by iMad on 11/07/2023.
//

import Foundation
import ProgressHUD
import Alamofire

class GFunction: NSObject {
    static let shared : GFunction = GFunction()
    
    //Check Connectivity
    func checkInternetConnectivity() {
        let manager = NetworkReachabilityManager()
        
        manager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                DispatchQueue.main.async {
                    GFunction.shared.showCustomAlert(title: "Notice", message: "Check your internet connection", buttonText: "OK")
                }
            case .reachable(let connectionType):
                switch connectionType {
                case .ethernetOrWiFi:
                    print("Connected via WiFi")
                case .cellular:
                    print("Connected via cellular data")
                }
            case .unknown:
                print("Unknown network status")
            }
        })
    }

    //Alert View
    func showCustomAlert(title: String, message: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Customize the alert appearance
        let titleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        
        let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        let buttonFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        let defaultAction = UIAlertAction(title: buttonText, style: .default) { _ in
            // Handle button tap
            // You can perform any action here based on the button tap
        }
        
        let redTextColor = UIColor.red
        defaultAction.setValue(redTextColor, forKey: "titleTextColor") // Set button text color to red
        
        alert.addAction(defaultAction)
        
        // Present the alert view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    //Loader
    func addLoader(_ message : String? = nil) {
        
            ProgressHUD.show(message ?? "Please Wait ...")
            ProgressHUD.animationType = .lineScaling
            ProgressHUD.colorHUD = .clear
            ProgressHUD.colorBackground = .clear
            ProgressHUD.colorStatus = .label
            ProgressHUD.fontStatus = .boldSystemFont(ofSize: 24)
    }
    
    func showSuccess(){
        ProgressHUD.showSuccess("Success", image: .checkmark, interaction: true)
    }
    
    func removeLoader() {
            ProgressHUD.dismiss()
     }
    
}
