//
//  ViewController.swift
//  ClientSwift
//
//  Created by RAHEESH ET on 03/09/20.
//  Copyright © 2020 ceino. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var signInButton: UIButton?
    @IBOutlet weak var registerButton: UIButton?
    //@IBOutlet weak var lblcovid: UILabel?
    @IBOutlet weak var lblcovid: UILabel!
    @IBOutlet weak var lblcrisisinfo: UILabel!
    
    let geoCoder = CLGeocoder()
    var locationManager:CLLocationManager!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

// MARK: - View cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let text = "Please agree for Terms & Conditions."
        lblTerms?.text = text
        self.lblTerms?.textColor =  UIColor.white
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions.")
                underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
                underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: Theme.Font.Regular, size: Theme.Font.size.lblSize)!, range: range1)
                underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: Theme.color.primaryGreen, range: range1)
        lblTerms?.attributedText = underlineAttriString
        lblTerms?.isUserInteractionEnabled = true
        lblTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))*/
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let covidmessagemutableAttributedString = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let firstcovidAttribute = [
            NSAttributedString.Key.font: UIFont(name: "Raleway-SemiBold", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle:style
        ]

        let secondcovidAttribute = [
            NSAttributedString.Key.font: UIFont(name: "Raleway-SemiBold", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue
            ] as [NSAttributedString.Key : Any]

        let firstcovidAttributedString = NSAttributedString(string: "If you think you have been exposed to COVID‑19 and develop a fever and symptoms, such as cough or difficulty breathing, call your healthcare provider for medical advice. ", attributes: firstcovidAttribute)
        let secondcovidAttributedString = NSAttributedString(string: "COVID Info.", attributes: secondcovidAttribute)
        covidmessagemutableAttributedString.append(firstcovidAttributedString)
        covidmessagemutableAttributedString.append(secondcovidAttributedString)

        //lblcovid?.attributedText = covidmessagemutableAttributedString
        
        let text = "If you think you have been exposed to COVID‑19 and develop a fever and symptoms, such as cough or difficulty breathing, call your healthcare provider for medical advice. COVID Info."
        lblcovid.text = text
       // lblcovid.textColor =  UIColor.white
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "COVID Info.")
                underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
                underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Raleway-SemiBold", size: 15)!, range: range1)
                underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
        lblcovid.attributedText = underlineAttriString
        lblcovid.isUserInteractionEnabled = true
        lblcovid.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        lblcrisisinfo.text = ""
        
        
        
     /*   let text2 = "If there is an emergency, please call 911 or rush to the nearest hospital. Crisis info."
         lblcrisisinfo.text = text2
         let crisisinfoAttriString = NSMutableAttributedString(string: text2)
         let range2 = (text2 as NSString).range(of: "Crisis info.")
                 crisisinfoAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
                 crisisinfoAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Raleway-SemiBold", size: 15)!, range: range2)
                 crisisinfoAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
         lblcrisisinfo.attributedText = crisisinfoAttriString
         lblcrisisinfo.isUserInteractionEnabled = true
         lblcrisisinfo.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapcrsisisLabel(gesture:))))*/
        
        
        
        
        
        
       
        
        
        signInButton?.layer.cornerRadius = 4
        signInButton?.layer.borderWidth = 1
        signInButton?.layer.borderColor = UIColor.white.cgColor
        
        
        registerButton?.layer.cornerRadius = 4
        registerButton?.layer.borderWidth = 1
        registerButton?.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    // MARK: - Core Location Delegate
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        
        guard let currentLocation = locations.first else { return }

        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else { return }
            print(currentLocPlacemark.country ?? "No country found")
            let countrycode =  currentLocPlacemark.isoCountryCode ?? "No country code found"
            self.appdelegate.countryCode = countrycode
            if countrycode == "US" {
                
                let text2 = "If there is an emergency, please call 911 or rush to the nearest hospital. Crisis info."
                self.lblcrisisinfo.text = text2
                        let crisisinfoAttriString = NSMutableAttributedString(string: text2)
                        let range2 = (text2 as NSString).range(of: "Crisis info.")
                                crisisinfoAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
                                crisisinfoAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Raleway-SemiBold", size: 15)!, range: range2)
                                crisisinfoAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
                self.lblcrisisinfo.attributedText = crisisinfoAttriString
                self.lblcrisisinfo.isUserInteractionEnabled = true
                self.lblcrisisinfo.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.tapcrsisisLabel(gesture:))))
                
               // println("These two strings are considered equal")
            }
            
            
        }
        
        
        
         locationManager.stopUpdatingLocation()
        /*let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)*/
        
        
    }
    
    // MARK: - Actions
    @IBAction func sighnbuttonTapped(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Sighn", bundle:nil)
               let loginviewcontroller = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginviewcontroller.strSighnin = "signin"
               self.navigationController?.pushViewController(loginviewcontroller, animated: true)
    }
    
    @IBAction func sighnupbuttonTapped(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Sighn", bundle:nil)
        let loginviewcontroller = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginviewcontroller.strSighnin = "sighnup"

        self.navigationController?.pushViewController(loginviewcontroller, animated: true)
       }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        
        let text = "If you think you have been exposed to COVID‑19 and develop a fever and symptoms, such as cough or difficulty breathing, call your healthcare provider for medical advice. COVID Info."
       let termsRange = (text as NSString).range(of: "COVID Info.")
       // comment for now
       //let privacyRange = (text as NSString).range(of: "Privacy Policy")

        if gesture.didTapAttributedTextInLabel(label: lblcovid, inRange: termsRange) {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let screenwebviewcontroller = storyBoard.instantiateViewController(withIdentifier: "ScreenWebViewController") as! ScreenWebViewController
            screenwebviewcontroller.strUrl = "https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/steps-when-sick.html"
                   self.navigationController?.pushViewController(screenwebviewcontroller, animated: true)
            print("Covid tapped")
        }
    }
    
    @IBAction func tapcrsisisLabel(gesture: UITapGestureRecognizer) {
           
           let text2 = "If there is an emergency, please call 911 or rush to the nearest hospital. Crisis info."
          let crisisRange = (text2 as NSString).range(of: "Crisis info.")
          // comment for now
          //let privacyRange = (text as NSString).range(of: "Privacy Policy")

           if gesture.didTapAttributedTextInLabel(label: lblcrisisinfo, inRange: crisisRange) {
               print("crisis tapped")
           }
       }
    
    
}
extension UITapGestureRecognizer {

func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
    // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer(size: CGSize.zero)
    let textStorage = NSTextStorage(attributedString: label.attributedText!)

    // Configure layoutManager and textStorage
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)

    // Configure textContainer
    textContainer.lineFragmentPadding = 0.0
    textContainer.lineBreakMode = label.lineBreakMode
    textContainer.maximumNumberOfLines = label.numberOfLines
    let labelSize = label.bounds.size
    textContainer.size = labelSize
    
     // Find the tapped character location and compare it to the specified range
            let locationOfTouchInLabel = self.location(in: label)
            let textBoundingBox = layoutManager.usedRect(for: textContainer)
            //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                                  //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
            let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

            //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                            // locationOfTouchInLabel.y - textContainerOffset.y);
            let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
            let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            return NSLocationInRange(indexOfCharacter, targetRange)
        }

    }
