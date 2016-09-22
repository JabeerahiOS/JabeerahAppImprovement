

import UIKit

class FirstViewController: UIViewController {

  
    @IBAction func EmailUrl(_ sender: AnyObject) {
        let email = "support@jabeerah.com"
        let mailurl = URL(string: "mailto:\(email)")
        UIApplication.shared.openURL(mailurl!)

    }
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

