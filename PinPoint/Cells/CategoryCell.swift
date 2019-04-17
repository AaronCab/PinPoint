//
//  CategoryCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    let categoryCellContainerView: UIView = {
        let categoryView = UIView()
        categoryView.backgroundColor = .white
        categoryView.layer.cornerRadius = 10
        categoryView.layer.masksToBounds = true
        return categoryView
    }()
    
    let categoryName: UILabel = {
        let catName = UILabel()
        catName.text = "Event Name"
        catName.numberOfLines = 2
        catName.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        catName.font = UIFont.init(name: "futura", size: 16)
        return catName
    }()
    
    let categoryImage: UIImageView = {
        let catImg = UIImageView()
        catImg.image = UIImage(named: "icons8-ask-question-25")
        catImg.contentMode = .scaleAspectFill
        catImg.layer.cornerRadius = 20
        catImg.layer.masksToBounds = true
        return catImg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.addSubview(categoryCellContainerView)
        
        categoryCellContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
            
        }
        categoryCellContainerView.addSubview(categoryName)
        
        categoryCellContainerView.addSubview(categoryImage)
        
        categoryName.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.height.equalTo(25)
            make.left.equalTo(20)
            make.width.equalTo(50)
        }
        
        categoryImage.snp.makeConstraints { (make) in
            make.top.equalTo(categoryName.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
    }
    
}
