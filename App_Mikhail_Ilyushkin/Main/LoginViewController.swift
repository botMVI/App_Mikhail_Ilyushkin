//
//  ViewController.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 23.09.2020.
//

import UIKit
//import WebKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
//
//    @IBOutlet weak var webView: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        var urlComponents = URLComponents()
//                urlComponents.scheme = "https"
//                urlComponents.host = "oauth.vk.com"
//                urlComponents.path = "/authorize"
//                urlComponents.queryItems = [
//                    URLQueryItem(name: "client_id", value: "7615257"),
//                    URLQueryItem(name: "display", value: "mobile"),
//                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//                    URLQueryItem(name: "scope", value: "262150"),
//                    URLQueryItem(name: "response_type", value: "token"),
//                    URLQueryItem(name: "v", value: "5.68")
//                ]
//
//                let request = URLRequest(url: urlComponents.url!)
//
//                webView.load(request)
//    }
//
//














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
        return true

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


