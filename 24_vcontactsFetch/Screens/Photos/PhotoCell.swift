//
//  PhotoCell.swift
//  ios-course-l21
//
//  Created by  AlexFount on 19.05.2022.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    //MARK: - Private properties
     lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
         image.contentMode = .scaleAspectFill
         image.clipsToBounds = true
        return image
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .white
        label.backgroundColor = UIColor(red: 0 , green: 0, blue: 0, alpha: 0.35)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    
    func configure(_ image: UIImage, _ likes: Int) {
        self.likesLabel.text = "♥︎\(likes) "
//        self.photoImageView.image = UIImage(named: imageName)
        self.photoImageView.image = image

    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likesLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 0),
            likesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
    }
    
}
