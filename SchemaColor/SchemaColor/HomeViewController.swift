//
//  HomeViewController.swift
//  SchemaColor
//
//  Created by Rome Rock on 2/24/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var menuItem: UIBarButtonItem!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var colorSampleView: UIView!
    @IBOutlet var restoreButton: UIButton!
    @IBOutlet var changeColorButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().panGestureRecognizer().delegate = self
        }
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 3
        contentView.layer.cornerRadius = 3
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.updateColor), name: .updateTheme, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.setFullVersion), name: .fullVersion, object: nil)
        
        updateColor()
        setFullVersion()
    }
    
    func updateColor() {
        
        var primaryColorHex = "17B0EF"
        
        if UserDefaults.standard.object(forKey: "primaryColor") != nil {
            primaryColorHex = UserDefaults.standard.string(forKey: "primaryColor")!
        }
        let primaryColor:UIColor = UIColor(hex: primaryColorHex)
        self.navigationController?.navigationBar.barTintColor = primaryColor
        colorSampleView.backgroundColor = primaryColor
        restoreButton.setTitleColor(primaryColor, for: .normal)
        changeColorButton.backgroundColor = primaryColor
    }
    
    func setFullVersion() {
        
        var isFullVersion = false
        
        if UserDefaults.standard.object(forKey: "fullVersion") != nil {
            isFullVersion = UserDefaults.standard.bool(forKey: "fullVersion")
        }
        
        restoreButton.isEnabled = isFullVersion
        statusLabel.textColor = UIColor(hex: isFullVersion ? "515151" : "#7E7E7E")
        statusLabel.text = isFullVersion ? "ON" : "OFF"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "fullVersion")
        UserDefaults.standard.removeObject(forKey: "primaryColor")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "secondaryColor")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .fullVersion, object: nil)
        NotificationCenter.default.post(name: .updateTheme, object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
