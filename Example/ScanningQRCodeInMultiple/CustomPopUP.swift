//
//  YesOrNoPopUp.swift
//  DhyanaNew
//
//  Created by Malleswari on 09/08/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import UIKit

class CustomPopUpview: UIView {
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var alphaView:UIView!
    var viewPopupBGView:UIView!
    var alertView:UIView!
    var headerView:UIView!
    var footerView:UIView!
    
    var titleLabel:UILabel!
    var messageLabel:UILabel!
    
    var noButton:UIButton!
    var yesButton:UIButton!
   
    var handler: ((Bool)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.alert()
        }, completion: { (finished) in
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func alert(){
        alphaView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.5
        self.addSubview(alphaView)
        
        viewPopupBGView = UIView(frame: CGRect(x: 0,y: 0,width: screenWidth,height: screenHeight))
        viewPopupBGView.backgroundColor = UIColor.clear
        self.addSubview(viewPopupBGView)
        
        alertView = UIView.init(frame: CGRect(x: screenWidth/2 - 140, y: screenHeight/2 - 75, width: 280, height: 150))
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 11
        alertView.clipsToBounds = true
        viewPopupBGView.addSubview(alertView)
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: alertView.frame.width, height: 10))
        headerView.backgroundColor = UIColor.clear
        alertView.addSubview(headerView)
        //print("headerview : \(headerView.bottom)")
        titleLabel = UILabel(frame: CGRect(x: 0, y: headerView.bottom, width: alertView.frame.width, height: 30))
        titleLabel.text = ""
        titleLabel.textColor = UIColor.themeColor
        titleLabel.font = UIFont.mediumFont(with: 20 )
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        headerView.addSubview(titleLabel)
        
//        footerView = UIView(frame: CGRect(x: 0 ,y: alertView.frame.height-40 , width: 280 , height: 30))
//        print("footerView: \(alertView.height)")
//        footerView.backgroundColor = UIColor.clear
//        alertView.addSubview(footerView)
        
        messageLabel = UILabel(frame: CGRect(x: 10 ,y: titleLabel.bottom , width: alertView.frame.width-30, height: 70))
        messageLabel.text = ""
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor.themeColor
        messageLabel.font = UIFont.appFont
        
        alertView.addSubview(messageLabel)
        //messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        //        messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 30).isActive = true
        //        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
       
    }
    
    func show(title: String, message: String,buttonTitle: [String], completionHandler:@escaping(Bool)->()){
        titleLabel.text = title
        messageLabel.text = message
        
        if buttonTitle.count > 1{
           print("numberof buttons is \(buttonTitle.count)")
            noButton = UIButton(frame: CGRect(x: 10, y: messageLabel.bottom, width: alertView.frame.width/2-20, height: 30))
            noButton.backgroundColor = UIColor.themeColor
            noButton.titleLabel?.textColor = UIColor.white
            noButton.layer.cornerRadius = 15
            noButton.titleLabel?.numberOfLines = 0
            noButton.titleLabel?.textAlignment = .center
            noButton.titleLabel?.font = UIFont.mediumFont(with: 18)
            noButton.addTarget(self, action: #selector(tappedOnNo), for: .touchUpInside)
            noButton.setTitle("", for: UIControlState())
            alertView.addSubview(noButton)
            
            yesButton = UIButton(frame: CGRect(x: noButton.width+30, y: messageLabel.bottom, width: alertView.frame.width/2-20, height: 30))
            yesButton.backgroundColor = UIColor.themeColor
            yesButton.titleLabel?.font = UIFont.mediumFont(with: 18)
            yesButton.titleLabel?.textColor = UIColor.white
            yesButton.layer.cornerRadius = 15
            yesButton.titleLabel?.numberOfLines = 0
            yesButton.titleLabel?.textAlignment = .center
            yesButton.addTarget(self, action: #selector(tappedOnYes(sender:)), for: .touchUpInside)
            yesButton.setTitle("", for: UIControlState())
            alertView.addSubview(yesButton)
            
            noButton.setTitle(buttonTitle[0], for: .normal)
            yesButton.setTitle(buttonTitle[1], for: .normal)
        
            handler = completionHandler
        }else{
            yesButton = UIButton(frame: CGRect(x: 25, y: messageLabel.bottom, width: alertView.frame.width-50, height: 30))
            yesButton.backgroundColor = UIColor.themeColor
            yesButton.titleLabel?.textColor = UIColor.white
            yesButton.titleLabel?.font = UIFont.mediumFont(with: 18)
            yesButton.layer.cornerRadius = 15
            yesButton.titleLabel?.numberOfLines = 0
            yesButton.titleLabel?.textAlignment = .center
            yesButton.addTarget(self, action: #selector(tappedOnNo(sender:)), for: .touchUpInside)
            yesButton.setTitle("", for: UIControlState())
            alertView.addSubview(yesButton)
            
            yesButton.setTitle(buttonTitle[0], for: .normal)
            handler = completionHandler
        }
    }
    //MARK: - Tapped On Button
    @objc  func tappedOnNo(sender: UIButton)
    {
        UIView.animate(withDuration: 0.5) {
            self.removeFromSuperViewWithAnimation()
            self.handler!(false)
        }
    }
    var tappedOnYes = false
    @objc func tappedOnYes(sender:UIButton){
            handler!(true)
    }

}
