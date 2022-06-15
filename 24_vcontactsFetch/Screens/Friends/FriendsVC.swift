//
//  TableViewController.swift
//  21_Table_Contacts
//
//  Created by ALexFount on 18.05.22.
//

import UIKit

struct Contact{
    var imageName: String
    var name: String
    var city: String
    var isOnline: Bool
    var personId: Int
}

 class FriendsVC: UIViewController {
    
    var friendsAPI = FriendsAPI()
    var friends: [FriendModel] = []
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        tableView.dataSource = self //Отвечает за данные
        tableView.delegate = self //Отвечает за поведение
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
//        friendsAPI.fetchFriends { [weak self] friends in
//            guard let self = self else { return }
//            self.friends = friends
//            self.tableView.reloadData()
//        }
        friendsAPI.fetchFriends { result in
            switch result {
            case .success(let friends):
                self.friends = friends
                self.tableView.reloadData()
            case .failure(let error):
                #if DEGUG
                self.showErrorAlert(title: error.description, message: "")
                #endif
                
            }
        }
        
    }
    

    private func setupView(){
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func goToPhotosVC(_ row: Int) {             //переход в VC друга и передача данных
        
        let photosVC = storyboard?.instantiateViewController(withIdentifier: "PhotosVC") as! PhotosVC
       // let photosVC = PhotosVC()

        print("goto PhotosVC")
        photosVC.personRow = row
        photosVC.friends = friends
        navigationController?.pushViewController(photosVC, animated: true)
        
    }
    
}

extension FriendsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FriendCell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as! FriendCell
        
        let friend = friends[indexPath.row]
        cell.configure(friend)
        
        return cell
    }
    
}

extension FriendsVC: UITableViewDelegate {        //переход по тапу ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        goToPhotosVC(indexPath.row)
        
    }
    
}


