//
//  ProfileViewController.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 23.09.2020.
//

import UIKit

enum ProfileCells: String, CaseIterable {
    case friends = "Друзья"
    case groups = "Группы"
    case music = "Музыка"
}

var namePic = ProfileTableViewCell()

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileCells.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCells = ProfileCells.allCases
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = profileCells[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = ProfileCells.allCases[indexPath.row]
        
        switch selectedCell {
        case .friends:
            let friendsVC = FriendsVC()
            navigationController?.pushViewController(friendsVC, animated: true)
        case .groups:
            let groupsVC = GroupsVC()
            navigationController?.pushViewController(groupsVC, animated: true)
        case .music:
            print("test")
        }
    }
    
    func showFriends() {
        let friendsVC = FriendsVC()
        navigationController?.pushViewController(friendsVC,animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView.instantiate()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
