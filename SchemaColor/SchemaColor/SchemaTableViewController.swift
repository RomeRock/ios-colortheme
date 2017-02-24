//
//  SchemaTableViewController.swift
//  SchemaColor
//
//  Created by Rome Rock on 2/22/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class SchemaTableViewController: UITableViewController {

    var schemas:[Schema] = []
    var statusBarBackground:UIView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        statusBarBackground = UIView(frame: CGRect(x: 0, y: -20, width:UIScreen.main.bounds.size.width, height:20))
        
        self.navigationController?.navigationBar.addSubview(self.statusBarBackground)
        
        let titleLabel:UILabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Select color theme"
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
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
        
        
        
        //tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateColor()
        
    }
    
    private func updateColor() {
        
        var primaryColor = "17B0EF"
        var secondaryColor = "0288D1"
        
        if UserDefaults.standard.object(forKey: "primaryColor") != nil {
            primaryColor = UserDefaults.standard.string(forKey: "primaryColor")!
        }
        
        if UserDefaults.standard.object(forKey: "secondaryColor") != nil {
            secondaryColor = UserDefaults.standard.string(forKey: "secondaryColor")!
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: primaryColor)
        self.statusBarBackground.backgroundColor = UIColor(hex: secondaryColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schemas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SchemaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SchemaTableViewCell
        
        cell.previewButton.isHidden = schemas[indexPath.row].isFree
        cell.previewLabel.isHidden = schemas[indexPath.row].isFree
        cell.nameLabel.text = schemas[indexPath.row].name
        cell.circleView.backgroundColor = UIColor(hex: schemas[indexPath.row].primaryColor)
        cell.selectedView.backgroundColor = UIColor(hex: schemas[indexPath.row].secondaryColor)
        
        if UserDefaults.standard.object(forKey: "name") != nil {
            if UserDefaults.standard.string(forKey: "name")! == schemas[indexPath.row].name {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schema:Schema = schemas[indexPath.row]
        UserDefaults.standard.set(schema.name, forKey: "name")
        UserDefaults.standard.set(schema.primaryColor, forKey: "primaryColor")
        UserDefaults.standard.set(schema.secondaryColor, forKey: "secondaryColor")
        UserDefaults.standard.synchronize()
        updateColor()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
