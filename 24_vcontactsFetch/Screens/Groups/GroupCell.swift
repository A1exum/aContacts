//
//  ContactCell.swift
//  21_Table_Contacts
//
//  Created by ALexFount on 18.05.22.
//

import UIKit
import SDWebImage

class GroupCell: UITableViewCell {
        
    static let identifier = "GroupCell"
    
    private  let photoImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let isOnlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstrains()
        
    }
    
    required init?(coder: NSCoder){
        fatalError("Init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    
    func configure(_ group: GroupModel){
        self.photoImageView.sd_setImage(with: URL(string: group.photo200 ?? ""), completed: nil)
        self.nameLabel.text = group.name
        self.cityLabel.text = "City"
      //  let isOnline: Bool =
       // self.isOnlineLabel.text = "Online \(group.online)"
        
        
//        if friend.isOnline {               //цвета лейбла
//            self.isOnlineLabel.blueColor()
//        }
//        else {
//            self.isOnlineLabel.greyColor()
//        }
                
    }
    
    //MARK: - Private
    private func setupViews(){
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(isOnlineLabel)
        
    }
    
    func setupConstrains(){
        let leftPadding: CGFloat = 20       //отступ вертикальный
        let topPadding: CGFloat = 5         // отступ горизонтальный
        
        NSLayoutConstraint.activate([           //фото
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: leftPadding),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topPadding)
        ])
        
        NSLayoutConstraint.activate([           //ИМЯ
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: leftPadding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.5 * topPadding)
        ])
        
        NSLayoutConstraint.activate([           //город
            cityLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: leftPadding),
            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant:  topPadding)
        ])
        
        NSLayoutConstraint.activate([       //статус онлайн
            isOnlineLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -leftPadding),
            isOnlineLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
