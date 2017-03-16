[![mm_header.jpg](https://s16.postimg.org/674mqlohx/mm_header.jpg)](https://postimg.org/image/dzvaikugx/)

# ios-colortheme
test case of changing theme color of the App

# Use

This project will show you how to change your custom themes and you will be able to unlock some other themes
We will retrieve the data from the `themes.json` file the structure of the json is the following

```json
	"themes": [
        {
               "name" : "<nameTheme>",
               "primaryColor" : "primaryColorHex",
               "secondaryColor" : "secondaryColorHex",
               "isFree" : true/false
        },....
    ]
```

In this project we use only two colors, but you can add as much as you want

In the `HomeViewController` we currently set the blue as the default theme, as you can see in the `updateColor()` function that we call in the `viewDidLoad` function

```swift
	func updateColor() {
        
        var primaryColorHex = "17B0EF"
        
        if UserDefaults.standard.object(forKey: "primaryColor") != nil {
            primaryColorHex = UserDefaults.standard.string(forKey: "primaryColor")!
        }
        
        var secondaryColorHex = "0288D1"
        
        if UserDefaults.standard.object(forKey: "secondaryColor") != nil {
            secondaryColorHex = UserDefaults.standard.string(forKey: "secondaryColor")!
        }
        
        let primaryColor:UIColor = UIColor(hex: primaryColorHex)
        self.navigationController?.navigationBar.barTintColor = primaryColor
        colorSampleView.backgroundColor = UIColor(hex: secondaryColorHex)
        restoreButton.setTitleColor(primaryColor, for: .normal)
        changeColorButton.backgroundColor = primaryColor
    }
```

### Retrieve Themes

If you look at the `SchemaTableViewController` file, specifically at the `viewDidLoad()` function, you will see how to retrieve the themes, and store in an Array

```swift
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
```

In the `tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell` is setting the cell for the theme and check if the theme is free or not, if is free you can selected otherwise will show you a pop up th=o give you the choise of unlock the themes

```swift
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SchemaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SchemaTableViewCell
        
        var isFullVersion = false
        
        if UserDefaults.standard.object(forKey: "fullVersion") != nil {
            isFullVersion = UserDefaults.standard.bool(forKey: "fullVersion")
        }
        
        cell.previewButton.isHidden = schemas[indexPath.row].isFree || isFullVersion
        cell.previewLabel.isHidden = schemas[indexPath.row].isFree || isFullVersion
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
```

Finally when you select a theme, it will be stored in the preferences and post the notification for any view that is observing

```swift
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schema:Schema = schemas[indexPath.row]
        UserDefaults.standard.set(schema.name, forKey: "name")
        UserDefaults.standard.set(schema.primaryColor, forKey: "primaryColor")
        UserDefaults.standard.set(schema.secondaryColor, forKey: "secondaryColor")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .updateTheme, object: nil)
    }
```

### Unlock Themes

As we mention, when a theme is locked and you click in the cell, this action will show you a pop up giving you the option to unlock these themes in the `prepare(forSegue:)` function from the `SchemaTableViewController` we specified which theme you selected and pass to the pop up

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is PreviewViewController {
            let destination:PreviewViewController = segue.destination as! PreviewViewController
            let button:UIButton = sender as! UIButton
            let customCell:SchemaTableViewCell = button.superview?.superview as! SchemaTableViewCell
            switch customCell.nameLabel.text! {
            case "GREEN":
                destination.current = 0
            case "PINK":
                destination.current = 1
            default:
                destination.current = 0
            }
        }
    }
```

Also in the `PreviewViewController` file, there is an example of how to use image gallery, feel free to do your own one based on this ;)
If you select the option of buy, will store the option in the user preferences and notify for refresh the theme's table view

```swift
	UserDefaults.standard.set(true, forKey: "fullVersion")
	UserDefaults.standard.synchronize()
	NotificationCenter.default.post(name: .fullVersion, object: nil)
```

## Example

[![color_2.gif](https://media.giphy.com/media/l0Iy9dMoAjZdyboA0/source.gif)](https://media.giphy.com/media/l0Iy9dMoAjZdyboA0/source.gif)

[![color_2.gif](http://gph.is/2mQe02a)](http://gph.is/2mQe02a)



## License

This project is is available under the MIT license. See the LICENSE file for more info. Attribution by linking to the [project page](https://github.com/RomeRock/ios-colortheme) is appreciated.

## Follow us!

<div>
<a href="http://romerock.com"> <img style="max-width: 100%; margin:7" src="https://avatars3.githubusercontent.com/u/23345883?v=3&s=200=true" alt="Google Play" height="50px" /> </a><a href="https://www.facebook.com/romerockapps/?ref=page_internal"> <img style="max-width: 100%; margin:7" src="https://s18.postimg.org/6sjokzpd5/facebook_icon.png=true" alt="Google Play" height="50px" /> </a><a href="https://twitter.com/romerock_apps"> <img style="max-width: 100%; margin:7" src="https://s18.postimg.org/w2eg82w4p/twitter_icon.png=true" alt="Google Play" height="50px" /> </a><a href="https://play.google.com/store/apps/dev?id=5841338539930209563"> <img style="max-width: 100%; margin:7" src="https://s18.postimg.org/n29unw015/android_icon.png=true" alt="Google Play" height="50px" /> </a><a href="https://itunes.apple.com/us/developer/rome-rock-llc/id1190244007"> <img style="max-width: 100%; margin:7" src="https://s18.postimg.org/leap98m5l/ios_icon.png=true" alt="Google Play" height="50px" /> </a><a href="https://github.com/RomeRock"> <img style="max-width: 100%; margin:7" src="https://s18.postimg.org/wpdcxlt0p/github_icon.png=true" alt="Google Play" height="50px" /> </a><a href="https://www.youtube.com/channel/UCcSLNuTYC7qJhOKQ4CpseRA"> <img style="max-width: 100%; margin:7" src="https://s18.postimg.org/w4ybuwzs9/youtube_icon.png=true" alt="Google Play" height="50px" /> </a>
</div>