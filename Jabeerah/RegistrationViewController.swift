//
//  RegistrationViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/17/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var RePasswordTF: UITextField!
    @IBOutlet weak var CityTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //To hide keyboard when pressing anything on screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register(_ sender: AnyObject) {
       
        if NameTF.text! == nil || EmailTF.text! == nil || PasswordTF.text! == nil || RePasswordTF == nil || PhoneTF.text! == nil || CityTF.text! == nil
        {
            let alert = UIAlertController(title: "عذرًا", message:"يجب عليك ملىء كل الحقول المطلوبة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
            
        } else {
            
            if PasswordTF.text != RePasswordTF.text {
                let alert = UIAlertController(title: "عذرًا", message:"كلمتي المرور غير متطابقتين", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                self.present(alert, animated: true){}
                
            } else {
                
                
                FIRAuth.auth()?.createUser(withEmail: EmailTF.text!, password: PasswordTF.text!, completion: { (user, err) in
                    print(err)
                   
                    if err != nil {
                        
                            switch FIRAuthErrorCode(rawValue:err!._code)! {
                                
                            case .errorCodeInvalidEmail:
                                let alert = UIAlertController(title: "عذرًا", message:"الإيميل غير صحيح", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                                self.present(alert, animated: true){}
                                
                            case .errorCodeEmailAlreadyInUse:
                                let alert = UIAlertController(title: "عذرًا", message:"الإيميل مستخدم", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                                self.present(alert, animated: true){}
                                
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
                
                    
                    }  else {
                        
                        FIRAuth.auth()?.signIn(withEmail: self.EmailTF.text!, password: self.PasswordTF.text!, completion: { (user, err) in
                            if let err = err {
                                print(err.localizedDescription)
                            } else {
                                
                               self.ref.child("UserProfile").child(user!.uid).setValue([
                                    "email": self.EmailTF.text!,
                                    "name" : self.NameTF.text!,
                                    "phone": self.PhoneTF.text!,
                                    "city" : self.CityTF.text!,
                                    "password": self.PasswordTF.text!
                                    ])
                                print("Sucess")
                                UserDefaults.standard.setValue(self.EmailTF.text, forKey: "email")
                                UserDefaults.standard.setValue(self.PasswordTF.text, forKey: "password")
                                

                            self.performSegue(withIdentifier: "SignUp", sender: nil)
                                
                            }
                        })
                        
                    } //else
                })
                
            } //Big else
            
            
        } //Big Big else
    }
    
    
}//end of



