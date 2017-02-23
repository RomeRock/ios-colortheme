//
//  ViewController.swift
//  SchemaColor
//
//  Created by Rome Rock on 2/22/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var schemas:[Schema] = []
        if let path = Bundle.main.path(forResource: "themes", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let themes : [NSDictionary] = jsonResult["themes"] as? [NSDictionary] {
                        for theme: NSDictionary in themes {
                            let schema:Schema = Schema(name: theme.object(forKey: "name") as! String, primaryColor: theme.object(forKey: "primaryColor") as! String, secondaryColor: theme.object(forKey: "secondaryColor") as! String, isFree: theme.object(forKey: "isFree") as! Bool)
                            schemas.append(schema)
                        }
                    }
                } catch {}
            } catch {}
        }
        for schema in schemas {
            print(schema.name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

