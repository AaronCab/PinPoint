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
    lazy var splashView: UIView = {
//        let vw = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        let vw = UIView()
     vw.backgroundColor = .white
        vw.layer.shadowColor = UIColor.black.cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.shadowOffset = CGSize.zero
        vw.layer.shadowRadius = 10
        vw.layer.shadowPath = UIBezierPath(rect: vw.bounds).cgPath
        vw.layer.shouldRasterize = true

        return vw
    }()
    
    
    let logoImage: UIImageView = {
        let li = UIImageView()
        li.layer.shadowColor = UIColor.black.cgColor
        li.layer.shadowOpacity = 1
        li.layer.shadowOffset = CGSize.zero
        li.layer.shadowRadius = 10
        li.layer.shadowPath = UIBezierPath(rect: li.bounds).cgPath
        li.layer.shouldRasterize = true
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
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        logoImage.snp.makeConstraints { (make) in
            make.center.equalTo(splashView.snp.center)
            make.height.equalTo(300)
            make.width.equalTo(350)
        }
       
        }
    
}
