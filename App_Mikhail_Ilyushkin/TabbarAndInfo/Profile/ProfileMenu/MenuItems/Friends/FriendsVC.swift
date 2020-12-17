//
//  FriendsVC.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 07.12.2020.
//

import UIKit
import Alamofire

fileprivate let cellID = "cellId"

struct FriendSt: Codable {
    let id: Int
    var firstName: String
    var lastName: String
    let city: City
}

struct City: Codable {
    let id: Int
    let title: String
}

class FriendsVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FriendsCell.self, forCellReuseIdentifier: cellID)
        
        configureAddBar()
        getFriends()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    fileprivate func configureAddBar() {
        navigationItem.title = "Друзья"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    @objc fileprivate func addFriend() {
        print("add Friend")
    }
    
    func getFriends() {
        let session = Session()

        var urlComponentsFriends = URLComponents()
        urlComponentsFriends.scheme = "https"
        urlComponentsFriends.host = "api.vk.com"
        urlComponentsFriends.path = "/method/friends.get"
        urlComponentsFriends.queryItems = [
//            URLQueryItem(name: "user_id", value: "625701893"),
            URLQueryItem(name: "field", value: "city"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.126")
        ]

//        let url = URL(string: "https://api.vk.com/method/friends.get?fields=city&access_token=15583ea4ff0862560cc7fa5e038fe65f8c764c51de91bd86e26765ded56eefec8f7a4bb4523212c50d6d4&v=5.126")!
        AF.request(urlComponentsFriends).responseData { response in
            guard let data = response.value,
                  let friend = try? JSONDecoder().decode([FriendSt].self, from: data)
            else {
                print("xui")
                return
            }

            print("Friends list:")
            print(friend)
//                    print(response.value!)
//                    print(urlComponentsFriends)
        }
    }
}

//    "first_name": "Никита",
//    "id": 6371624,
//    "last_name": "Ефименко",
//    "can_access_closed": true,
//    "is_closed": false,
//    "city": {
//    "id": 104,
//    "title": "Омск"
//    },
//    "track_code": "8904d9c4QVrZHGWqOpYWVxeIvBUH5_jgaC4SkmDTIjCmhMSnDKEgOe0tZ6ponhFRI2dHszSe--ABSw"
//    },
   
//    https://api.vk.com/method/friends.get?fields=city&access_token=15583ea4ff0862560cc7fa5e038fe65f8c764c51de91bd86e26765ded56eefec8f7a4bb4523212c50d6d4&v=5.126
