

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class loginViewController: UIViewController {
    
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

   
   // let ref = FIRDatabase.database().reference()
    override func viewDidAppear(_ animated: Bool) {
        
        if FIRAuth.auth()?.currentUser != nil
        {
            print("there is a user already signed in")
            self.performSegue(withIdentifier: "SignIn", sender: self)
        }
        else
        {
            print("You have to login or sign up")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SignIn(_ sender: UIButton) {
  
        guard let Email = UserEmail.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !Email.isEmpty else{
         
            print("Email is Empty")
            
            let alert = UIAlertController(title: "Email is Empty", message: "الرجاء كتابة البريد الإلكتروني", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction)in
                
                self.UserEmail.becomeFirstResponder()
                
                }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
                
        guard let Password = UserPassword.text , !Password.isEmpty else {
            
            print("Password is Empty")
            
            let alert = UIAlertController(title: "Password is Empty", message: "االرجاء إدخال كلمة المرور ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction)in
                
                self.UserPassword.becomeFirstResponder()
                
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        self.view.endEditing(true)
        FIRAuth.auth()?.signIn(withEmail: Email, password: Password, completion: { (user, err) in
         
            //check password here
            
            if let err = err {
                print(err)
                
                if err._code == 17011 {
                    let alert = UIAlertController (title: "المستخدم غير موجود", message: " المستخدم غير موجود ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction)in
                        
                        self.UserEmail.becomeFirstResponder()
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    if err._code == 17009 {
                        
                        let alert = UIAlertController (title: "كلمة المرور غير صحيحة", message: " كلمة المرور غير صحيحة", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction)in
                            
                            self.UserPassword.becomeFirstResponder()
                            
                        }))
                     //   self.presentViewController(alert, animated: true, completion: nil)
                        
                        // the password is invalid
                    }
                }
                
            }else{
                if user != nil {
                    print("user")
                     self.performSegue(withIdentifier: "SignIn", sender: nil)
                    UserDefaults.standard.setValue(self.UserEmail.text, forKey: "email")
                    UserDefaults.standard.setValue(self.UserPassword.text, forKey: "password")
             //    let sb = UIStoryboard(name: "Main", bundle: nil)
              //      let vc = sb.instantiateViewControllerWithIdentifier("Home")
             //       self.presentedViewController(vc, animated: true, completion: nil)
                    
                } // هذي نعدلها بعدين بحيث اول مايسوي لوق ان يوديه مباشره للديفايز تاب
            }
        })

      
        
    }// end of signin
    
    
    
    
  

   
    

}//

