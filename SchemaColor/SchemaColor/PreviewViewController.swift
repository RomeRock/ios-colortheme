//
//  PreviewViewController.swift
//  SchemaColor
//
//  Created by NDM on 2/25/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet var buyButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var current:Int = 0
    var images:[String] = ["img_preview_green", "img_preview_pink"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateColor()
        
        pageControl.currentPage = 0
    }
    
    func updateColor() {
        
        var primaryColorHex = "17B0EF"
        
        if UserDefaults.standard.object(forKey: "primaryColor") != nil {
            primaryColorHex = UserDefaults.standard.string(forKey: "primaryColor")!
        }
        let primaryColor:UIColor = UIColor(hex: primaryColorHex)
        
        noButton.setTitleColor(primaryColor, for: .normal)
        noButton.layer.borderColor = primaryColor.cgColor
        buyButton.backgroundColor = primaryColor
        titleLabel.textColor = primaryColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if current > 0 {
            images.insert(images.remove(at: current), at: 0)
        }
        
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for index in 0...(images.count - 1) {
            let image = UIImageView(frame: CGRect(x:scrollViewWidth * CGFloat(index), y:0,width:scrollViewWidth, height:scrollViewHeight))
            image.image = UIImage(named: images[index])
            scrollView.addSubview(image)
        }
        
        self.scrollView.contentSize = CGSize(width:(self.scrollView.frame.width * CGFloat(images.count) ), height:self.scrollView.frame.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch? = touches.first
        let touchLocation = touch?.location(in: self.view)
        let contentViewFrame = self.view.convert(contentView.frame, from: contentView.superview)
        if !contentViewFrame.contains(touchLocation!) {
            dismiss(animated: true, completion:nil)
        }
        
    }
    @IBAction func buyButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "fullVersion")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .fullVersion, object: nil)
        dismiss(animated: true, completion:nil)
    }

    @IBAction func noButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = self.scrollView.frame.width
        let currentPage:CGFloat = floor((self.scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        
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
