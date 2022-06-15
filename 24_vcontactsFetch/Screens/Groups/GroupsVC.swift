//
//  TableViewController.swift
//  21_Table_Contacts
//
//  Created by ALexFount on 18.05.22.
//

import UIKit



final class GroupsVC: UIViewController {
    
    var groupsAPI = GroupsAPI()
    var groups: [GroupModel] = []
    
   // var FriendViewController: PhotosVC?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        tableView.dataSource = self //Отвечает за данные
        tableView.delegate = self //Отвечает за поведение
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        groupsAPI.fetchGroups { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups
            self.tableView.reloadData()
        }
        
    }
    
    private func setupView(){
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func goToPhotosVC(_ row: Int) {             //переход в VC друга и передача данных
       // guard  let newVC = (storyboard?.instantiateViewController(withIdentifier: "PhotosVC")) as?  PhotosVC  else {return}
        let photosVC = PhotosVC()

        navigationController?.pushViewController(photosVC, animated: true)
        
    }
    
}

extension GroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GroupCell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        
        let group = groups[indexPath.row]
        cell.configure(group)
        
        return cell
    }
    
}

extension GroupsVC: UITableViewDelegate {        //переход по тапу ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        goToPhotosVC(indexPath.row)
        
    }
    
}


