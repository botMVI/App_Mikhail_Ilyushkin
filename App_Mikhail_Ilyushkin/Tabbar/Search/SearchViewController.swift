//
//  SearchViewController.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 23.09.2020.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        switch indexPath.row {
        case 0:
            cell.pic1.image = UIImage(named: "img1")
            cell.pic2.image = UIImage(named: "img2")
        case 1:
            cell.pic1.image = UIImage(named: "img3")
            cell.pic2.image = UIImage(named: "img4")
        default:
            cell.pic1.image = UIImage(named: "img5")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
