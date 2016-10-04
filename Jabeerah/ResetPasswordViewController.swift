//
//  ResetPasswordViewController.swift
//  Jabeerah
//
//  Created by Ruba O on 11/22/1437 AH.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

 
    @IBOutlet weak var EmailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SendButton(_ sender: AnyObject) {
        if self.EmailTF.text == ""
        {
            let alertController = UIAlertController(title: "عفواً", message: "الرجاء إدخال بريدك الالكتروني", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.sendPasswordReset(withEmail: self.EmailTF.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil
                {
                    title = "عفواً!"
                    message = (error?.localizedDescription)!
                    
                }
                else
                {
                    title = "ممتاز!"
                    message = "تم ارسال كلمة المرور"
                    self.EmailTF.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
    }



