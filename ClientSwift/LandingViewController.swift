//
//  LandingViewController.swift
//  ClientSwift
//
//  Created by RAHEESH ET on 04/09/20.
//  Copyright © 2020 ceino. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(viewcontroller, animated: true)
   // let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    //self.navigationController?.pushViewController(viewcontroller, animated: true)
        // Do any additional setup after loading the view.
    }
    

    
  /*  // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
