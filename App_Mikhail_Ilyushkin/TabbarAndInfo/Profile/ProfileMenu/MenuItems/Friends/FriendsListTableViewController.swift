//
//  FriendsListTableViewController.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 28.09.2020.
//

import UIKit

class FriendsListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var friendTableView: UITableView!
    
    var users = [
        User(name: "Жора", photo: UIImage(named: "image1")!),
        User(name: "Андрей", photo: UIImage(named: "image1")!),
        User(name: "Галя", photo: UIImage(named: "image1")!),
        User(name: "Беня", photo: UIImage(named: "image1")!),
        User(name: "Вова", photo: UIImage(named: "image1")!),
        User(name: "Егор", photo: UIImage(named: "image1")!),
        User(name: "Данил", photo: UIImage(named: "image1")!)
    ]
    
    
    var filtredUsers: [User] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtredUsers = users

        tableView.dataSource = self
        tableView.delegate = self
    }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") {
                let friend = filtredUsers[indexPath.row]
                cell.textLabel?.text = friend.name
                cell.imageView?.image = friend.photo
            
                return cell
            }
            fatalError()
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let friendCollectionVC = storyboard.instantiateViewController(identifier: "FriendsCollectionViewController") as! FriendsCollectionViewController
        
        let user = users[indexPath.row]
        
        friendCollectionVC.selectedImage = user.photo
        
        navigationController?.pushViewController(friendCollectionVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let index = self.tableView.indexPathForSelectedRow
//        let indexNumber = index?.row
//        let vc = segue.destination as! FriendsCollectionViewController
//        vc.final_names = friends[indexNumber!]
//        vc.final_image = users[indexNumber!]
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            filtredUsers = users
            
        } else {
            
            filtredUsers = users.filter({ (user) -> Bool in
                return user.name.contains(searchBar.text ?? "")
            })
        }
        
        tableView.reloadData()
    }
}
