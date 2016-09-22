//
//  EditPasswordViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/29/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditPasswordViewController: UIViewController {

    @IBOutlet weak var NewPassword: UITextField!
    @IBOutlet weak var ReNewPassword: UITextField!
    
     let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EditPassword(_ sender: AnyObject) {
        if NewPassword.text == "" || ReNewPassword.text == "" {
            let alert = UIAlertController(title: "عذرًا", message:"يجب عليك ملىء كل الحقول المطلوبة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}

        } else {
        
            if NewPassword.text != ReNewPassword.text {
                
                let alert = UIAlertController(title: "عذرًا", message:"كلمتي المرور غير متطابقتين", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                self.present(alert, animated: true){}
            
            } else {
            
             FIRAuth.auth()!.currentUser!.updatePassword(NewPassword.text!, completion: { (error) in
                
                if error != nil {
                    
                    switch FIRAuthErrorCode(rawValue:error!._code)! {
                    case .errorCodeNetworkError:
                        let alert = UIAlertController(title: "عذرًا", message:"خطأ في الشبكة", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    case .errorCodeWeakPassword:
                        let alert = UIAlertController(title: "عذرًا", message:"كلمة المرور ضعيفة", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    default:
                        let alert = UIAlertController(title: "عذرًا", message:"خطأ غير معروف", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    }
                
                } else {
                print("Password Updated Successfully")
                self.performSegue(withIdentifier: "EditPassword", sender: nil)
                
                }
                
             })
            
            
            
            }
        }
        
     
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
