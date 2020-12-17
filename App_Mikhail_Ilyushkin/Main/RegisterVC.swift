//
//  RegisterVC.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 15.12.2020.
//

import UIKit
import Firebase

class RegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewComponents()
        setupNotificationObserver()
        setupTapGesture()
        handlers()
    }
    
    var imageSelected = false
    
    fileprivate let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выберите фото", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.rgb(red: 149, green: 204, blue: 244).cgColor
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        
        return button
    }()
    
    @objc fileprivate func selectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        imageSelected = true
        
        selectPhotoButton.layer.cornerRadius = selectPhotoButton.frame.width / 2
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.backgroundColor = UIColor.black.cgColor
        selectPhotoButton.layer.borderWidth = 2
        selectPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Handlers
    
    fileprivate func handlers() {
        emailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        loginTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    @objc fileprivate func formValidation() {
        guard emailTextField.hasText,
              nameTextField.hasText,
              fullNameTextField.hasText,
              phoneTextField.hasText,
              loginTextField.hasText,
              passwordTextField.hasText,
              imageSelected == true else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            return
        }
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    @objc fileprivate func handleSignUp() {
        self.handleTapDismiss()
        
        guard let email = emailTextField.text?.lowercased() else { return }
        guard let name = nameTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let login = loginTextField.text?.lowercased() else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            print("Пользователь успешно создан")
            
            guard let profileImage = self.selectPhotoButton.imageView?.image else { return }
            guard let uploadData = profileImage.jpegData(compressionQuality: 0.3) else { return }
            
            let filname = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_image").child(filname)
            
            storageRef.putData(uploadData, metadata: nil) { (_, err) in
                if let err = err {
                    print("Не удалось загрузить фото", err.localizedDescription)
                    return
                }
                print("Загрузка прошла успешно")
                
                storageRef.downloadURL { (downloadURL, err) in
                    guard let profileImageUrl = downloadURL?.absoluteString else { return }
                    if let err = err {
                        print("Profile image wasnt upload", err.localizedDescription)
                        return
                    }
                    print("Profile image was uploaded")
                    
                    guard let uid = user?.user.uid else { return }
                    
                    let dictionaryValue = ["name": fullName, "username": login, "profileImageUrl": profileImageUrl]
                    let values = [uid:dictionaryValue]
                    
                    Firestore.firestore().collection("users").document(uid).setData(values) { (err) in
                        if let err = err {
                            print("Failed", err.localizedDescription)
                        }
                        print("Data was succesfully uploaded")
                    }
                }
            }
            
        }
    }
    
    fileprivate let nameTextField = UITextField.setupTextField(title: "Имя", secureText: false)
    fileprivate let fullNameTextField = UITextField.setupTextField(title: "Фамилия", secureText: false)
    fileprivate let emailTextField = UITextField.setupTextField(title: "Email", secureText: false)
    fileprivate let phoneTextField = UITextField.setupTextField(title: "Телефон", secureText: false)
    fileprivate let loginTextField = UITextField.setupTextField(title: "Логин", secureText: false)
    fileprivate let passwordTextField = UITextField.setupTextField(title: "Пароль", secureText: true)
    fileprivate let signUpButton = UIButton.setupButton(title: "Регистрация", color: UIColor.rgb(red: 149, green: 204, blue: 244))
    
    fileprivate let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Уже зарегистрированы? ", attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Войти", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .heavy), .foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToLoginVC), for: .touchUpInside)
        
        return button
    }()
    
    @objc fileprivate func goToLoginVC() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Constraints
    
    lazy var stackView = UIStackView(arrangedSubviews: [emailTextField, nameTextField, fullNameTextField, phoneTextField, loginTextField, passwordTextField])
    
    fileprivate func configureViewComponents() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 250, height: 250))
        selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectPhotoButton.layer.cornerRadius = 250 / 2
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: selectPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 320))
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: stackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 40))
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 10, right: 40))
    }
    
    // MARK: - Keyboard
    
    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 10)
        
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { self.view.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
}
