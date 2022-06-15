//
//  HeaderCollectionView.swift
//  22_vcontacts
//
//  Created by ALexFount on 23.05.22.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionView"
    
    var imageHeight = NSLayoutConstraint()
    var imageBottom = NSLayoutConstraint()
    var imageWidth = NSLayoutConstraint()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text =  "Header"
        label.font = UIFont(name: "Arial", size: 35)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowRadius = 18
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.9
        label.layer.masksToBounds = false

        return label
    }()
    
    var imageView: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "city"))
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleAspectFill
        imageV.alpha = 1
        imageV.frame = CGRect(x: 0, y: 0, width: 300, height: 60)
        return imageV
    }()
    
    public func configure(_ headerText: String){
        contentMode = .scaleAspectFill
        //clipsToBounds = true
        //backgroundColor = .lightGray
        headerLabel.text = headerText
        addSubview(imageView)
        addSubview(headerLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageBottom = imageView.bottomAnchor.constraint(equalTo:  bottomAnchor)
        addConstraint(imageBottom)
        
        imageHeight = imageView.heightAnchor.constraint(equalToConstant: bounds.height)
        addConstraint(imageHeight)
        imageWidth = imageView.widthAnchor.constraint(equalToConstant: bounds.width)
        addConstraint(imageWidth)
            
    }
    
    func changeImageHeight(_ heightIn: CGFloat){
        
        imageHeight.constant = heightIn
        print("changeImageHeightF", heightIn, imageHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = imageView.frame
        //imageView.frame = bounds
        
    }
 
}
