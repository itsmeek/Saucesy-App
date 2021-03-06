//
//  Extensions.swift
//  Saucesy
//
//  Created by Meeky Dekowski on 12/3/16.
//  Copyright © 2016 Saucesy. All rights reserved.
//

import UIKit

// Adds subtle shadow to collection view cell
extension UICollectionViewCell {
    func addShadow(){
        let grey: CGFloat = 190/225
        self.layer.shadowColor = UIColor(red: grey, green: grey, blue: grey, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
    }
}

// Saucesy app theme colors
extension UIColor{
    
    public class var saucesyRed: UIColor
    {
        return UIColor(red:234/255, green:84/255, blue:85/255, alpha:1.0)
    }
    
    public class var saucesyBlue: UIColor
    {
        return UIColor(red:45/255, green:64/255, blue:89/255, alpha:1.0)
    }
    
    public class var saucesyLightBlue: UIColor
    {
        return UIColor(red:89/255, green:105/255, blue:126/255, alpha:1.0)
    }

}

// Custom extension to add constraints easily
extension UIView {
    //parameters are strings and array of uiviews
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}


//Hides tab bar with animation when scrolling down
extension UIViewController {
    
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
}

extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}

extension UIViewController {
    func alert(message: String, title: String = ""){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)!
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                //Store inside image cache
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
                
            })
            
        }).resume()
    }
}

class SaucesyLabel{
    class func setAttributedText(on: UILabel, data: Int, append: String){
        
            let caloriesLabel = "\(data) \(append.uppercased())"
            let caloriesText = "\(data)"
            on.textColor = UIColor.saucesyBlue
            
            let range = (caloriesLabel as NSString).range(of: caloriesText)
            let attributedString = NSMutableAttributedString(string: caloriesLabel)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.saucesyRed , range: range)
            on.attributedText = attributedString
    }
}



