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
       
        //I used the same way in login to check if textfields are empty! 
        //Because after the update the previous way is no longer working!
        
        //Checking if Name is empty
        guard let Name = NameTF.text , !Name.isEmpty else {
            print("Name is Empty")
            let alert = UIAlertController(title: "عذرًا", message: "الرجاء إدخال الاسم", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                self.NameTF.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //Checkng if Email is empty
        guard let Email = EmailTF.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !Email.isEmpty else{
        print("Email is Empty")
        let alert = UIAlertController(title: "عذرًا", message: "الرجاء إدخال البريد الإلكتروني", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
        self.EmailTF.becomeFirstResponder()
        }))
        self.present(alert, animated: true, completion: nil)
        return
        }
        //Checking if Phone is empty
        guard let Phone = PhoneTF.text , !Phone.isEmpty else {
            print("Phone is Empty")
            let alert = UIAlertController(title: "عذرًا", message: "الرجاء إدخال رقم الهاتف", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                self.PhoneTF.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //Checking if Password is empty
        guard let Password = PasswordTF.text , !Password.isEmpty else {
        print("Password is Empty")
        let alert = UIAlertController(title: "عذرًا", message: "الرجاء إدخال كلمة المرور", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
        self.PasswordTF.becomeFirstResponder()
        }))
        self.present(alert, animated: true, completion: nil)
        return
        }
        
        //Checking if rePassword is empty
        guard let Repassword = RePasswordTF.text , !Repassword.isEmpty else {
        print("RePassword is Empty")
            let alert = UIAlertController(title: "عذرًا", message: "الرجاءإعادة إدخال كلمة المرور", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                self.RePasswordTF.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
        return
        }
        
        
        //Checking if City is empty
        guard let City = CityTF.text , !City.isEmpty else {
            print("City is Empty")
            let alert = UIAlertController(title: "عذرًا", message: "الرجاء إدخال المدينة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                self.CityTF.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
       self.view.endEditing(true)
        
        
        /* if NameTF.text == nil || EmailTF.text == nil || PasswordTF.text == nil || RePasswordTF == nil || PhoneTF.text == nil || CityTF.text == nil
         {
         let alert = UIAlertController(title: "عذرًا", message:"يجب عليك ملىء كل الحقول المطلوبة", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
         self.present(alert, animated: true){}
         
         } */
        /*   else {
         
         } //Big Big else */
        
        if PasswordTF.text != RePasswordTF.text {
            let alert = UIAlertController(title: "عذرًا", message:"كلمتي المرور غير متطابقتين", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
            
        } else {
            
            
            FIRAuth.auth()?.createUser(withEmail: EmailTF.text!, password: PasswordTF.text!, completion: { (user, err) in
                print(err)
                
                if err != nil {
                    
                    if let errCode = FIRAuthErrorCode(rawValue: err!._code) {
                        
                        switch errCode {
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
                            
                            //Not sure if we are going to use this.
                            UserDefaults.standard.setValue(self.EmailTF.text, forKey: "email")
                            UserDefaults.standard.setValue(self.PasswordTF.text, forKey: "password")

                            self.performSegue(withIdentifier: "SignUp", sender: nil)
                            
                        }
                    })
                    
                } //else
            })
            
        } //Big else
        
    } //SignUp Button

}//UIView Controller



