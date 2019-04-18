//
//  HomeSplashView.swift
//  PinPoint
//
//  Created by Jeffrey Almonte on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class HomeSplashView: UIView {
    // don't forget merge this new file
    lazy var splashView: UIView = {
        let vw = UIView(frame: CGRect(x: 100, y: 100, width: 128, height: 128))
        vw.backgroundColor = #colorLiteral(red: 0.9615442157, green: 0.1090296283, blue: 0.1115608588, alpha: 1)
        vw.layer.shadowOffset = .zero
        vw.layer.shadowColor = UIColor.yellow.cgColor
        vw.layer.shadowRadius = 20
        vw.layer.shadowOpacity = 1
        vw.layer.shadowPath = UIBezierPath(rect: vw.bounds).cgPath
        return vw
    }()
    
    
    let logoImage: UIImageView = {
        let li = UIImageView()
        li.image = UIImage(#imageLiteral(resourceName: "IMG_0279.PNG"))
        return li
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit(){
        setUpView()
    }
    
    private func setUpView() {
        self.addSubview(splashView)
        splashView.addSubview(logoImage)
        splashView.snp.makeConstraints { (make) in
            make.centerWithinMargins.equalToSuperview()
           make.top.right.equalTo(50)
            make.bottom.left.equalTo(-50)
        }
        logoImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(350)
        }
       
        }
    
}
