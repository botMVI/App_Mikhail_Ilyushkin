//
//  ViewController.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 23.09.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
//
//            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
//            let vc = storyboard.instantiateViewController(identifier: "Tabbar")
//            self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let checkResult = checkUserData()
        
        if !checkResult {
            showLoginError()
        }
        return checkResult
    }
    
    func checkUserData() -> Bool {
//        return true
        
        guard let login = loginInput.text,
            let password = pwdInput.text else { return false }
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
}


