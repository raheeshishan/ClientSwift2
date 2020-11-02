//
//  LoginViewController.swift
//  ClientSwift
//
//  Created by RAHEESH ET on 16/10/20.
//  Copyright © 2020 ceino. All rights reserved.
//

import UIKit




class LoginViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
 let appdelegate = UIApplication.shared.delegate as! AppDelegate

    
var strSighnin = ""
var strcountryCode = ""
var strCounryName = ""

@IBOutlet weak var flagTableView: UITableView!
@IBOutlet weak var imgFlagSelected: UIImageView!
@IBOutlet weak var txtMobileNumber: UITextField!

let flagArray = ["usa", "canada", "india", "uae"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flagTableView.isHidden = true
        
        self.navigationController?.isNavigationBarHidden = false
        
       // print("998-877-2211".isValidPhone)

        
        
        if strSighnin == "signin" {
            
            self.navigationItem.title = "SIGN IN"


        }
        else {
            
            self.navigationItem.title = "REGISTER"


        }
        
        
        if self.appdelegate.countryCode == "IN" {
          self.strcountryCode = "+91"
          self.appdelegate.countryDigitCode = "+91"
          self.imgFlagSelected.image = UIImage(named:"india")
          self.strCounryName = "India";
        }
        
        else if self.appdelegate.countryCode == "CA" || self.appdelegate.countryCode == "Canada" {
            self.strcountryCode = "+1"
            self.appdelegate.countryDigitCode = "+1"
            self.imgFlagSelected.image = UIImage(named:"canada")
            self.strCounryName = "Canada";

        }
        else {
            self.strcountryCode = "+1"
            self.appdelegate.countryDigitCode = "+1"
            self.imgFlagSelected.image = UIImage(named:"usa")
            self.strCounryName = "US";

        }

        self.addDoneButtonOnKeyboard()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func flagbuttonTapped(_ sender: UIButton) {
        self.flagTableView.isHidden = false
        
    }
    @IBAction func confirmationButtonTapped(_ sender: UIButton) {
        
        var errormessage:String = ""

    
        if (!txtMobileNumber.text!.isEmpty) {
            
           // let phoneString = "\(self.strcountryCode)\(String(describing: txtMobileNumber.text))"
            let phoneString = txtMobileNumber.text

            let phoneNumberValidator = phoneString!.isPhoneNumber
            
            if phoneNumberValidator {
                            return

            }
            else {
                errormessage = "Please enter correct number"

            }
            print(phoneNumberValidator)
        // enable button
        } else {
            
            errormessage = "Please add Phone number"
            
        // disable button
        }
       
        let alert = UIAlertController(title: "", message: errormessage, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        

    }
    // MARK - UITableView Delegates
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cellIdentifier = "flagcell"
        
               var cell: FlagTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FlagTableViewCell

               if cell == nil {
                   cell = FlagTableViewCell()
               }

        let strimage = flagArray[indexPath.row]
        cell.flgImage.image = UIImage(named:strimage)
              
       
        
               return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let strselectimage = flagArray[indexPath.row]
        self.imgFlagSelected.image = UIImage(named:strselectimage)
        
        if indexPath.row == 0 {
            self.strcountryCode = "+1";
            self.appdelegate.countryDigitCode = "+1";

            self.strCounryName = "US";


        }
        else if indexPath.row == 1{
            self.strcountryCode = "+1";
            self.appdelegate.countryDigitCode = "+1";
            self.strCounryName = "Canada";


            
        }
        
        else if indexPath.row == 2{
            self.strcountryCode = "+91";
            self.appdelegate.countryDigitCode = "+91";

            self.strCounryName = "India";


            
        }
        
        else if indexPath.row == 3{
            self.strcountryCode = "+971";
            self.appdelegate.countryDigitCode = "+971";

            self.strCounryName = "UAE";
            
            
            
        }
        
        self.flagTableView.isHidden = true
        
       
        
    }
  
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        txtMobileNumber.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        txtMobileNumber.resignFirstResponder()
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

/*extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
   var isValidPhone: Bool {
      let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
      return testPhone.evaluate(with: self)
   }
}*/
extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
