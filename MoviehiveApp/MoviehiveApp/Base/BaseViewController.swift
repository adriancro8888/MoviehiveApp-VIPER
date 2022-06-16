//
//  BaseViewController.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 26.04.2022.
//

import UIKit
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showAlert(title: String, message: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
        
        print("Alert tetiklendi")
    }

}
