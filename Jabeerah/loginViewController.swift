

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class loginViewController: UIViewController {
    
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
  
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
  
        //Checkng if email is empty
        guard let Email = UserEmail.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !Email.isEmpty else{
         
            print("Email is Empty")
            
            let alert = UIAlertController(title: "عذرًا", message: "الرجاء كتابة البريد الإلكتروني", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                
                self.UserEmail.becomeFirstResponder()
                
                }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        //Checking if password is empty
        guard let Password = UserPassword.text , !Password.isEmpty else {
            
            print("Password is Empty")
            
            let alert = UIAlertController(title: "عذرًا", message: "الرجاء إدخال كلمة المرور", preferredStyle: .alert)
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
                    let alert = UIAlertController (title: "عذرًا", message: "المستخدم غير موجود", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                        
                        self.UserEmail.becomeFirstResponder()
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    if err._code == 17009 {
                        
                        let alert = UIAlertController (title: "عذرًا", message: "كلمة المرور غير صحيحة", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
                            
                            self.UserPassword.becomeFirstResponder()
                            
                        }))
                     //   self.presentViewController(alert, animated: true, completion: nil)
                        
                        // the password is invalid
                    }
            }
           }
           
          //I have added this to check all the cases of errors! But I have not tested it yet!
            /*
            if err != nil {
                
                if let errCode = FIRAuthErrorCode(rawValue: err!._code) {
                    
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        let alert = UIAlertController(title: "عذرًا", message:"الإيميل غير صحيح", preferredStyle: .alert)
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

            }*/
            
            else{
                if user != nil {
                    print("user")
                     self.performSegue(withIdentifier: "SignIn", sender: nil)
                    UserDefaults.standard.setValue(self.UserEmail.text, forKey: "email")
                    UserDefaults.standard.setValue(self.UserPassword.text, forKey: "password")
  
                } 
            }
        })

      
        
    }// end of signin
    
 

}//

