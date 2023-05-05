//
//  AuthViewController.swift
//  tinder-demo
//
//  Created by urcop on 04.05.2023.
//

import UIKit
import Firebase


class AuthViewController: UIViewController {
    
    var isSignUp: Bool = true{
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                nameField.isHidden = false
                enterButton.setTitle("Войти", for: .normal)
            }else{
                titleLabel.text = "Вход"
                nameField.isHidden = true
                enterButton.setTitle("Регистрация", for: .normal)
            }
        }
    }
    
    @IBAction func switchLogin(_ sender: UIButton) {
        isSignUp = !isSignUp
    }

    @IBOutlet weak var nameField: UITextField!

    @IBAction func signUpButton(_ sender: UIButton) {
    }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
//        signUpButton.addTarget(self, action: #selector(register), for: .touchUpInside)

    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func registerButtonTapped(_sender: UIButton){
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!

        if (isSignUp){
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil{
                        if let result = result {
                            print(result.user.uid)
                        }
                    }
                }
            }else{
                showAlert()
            }
        }else {
            if (!email.isEmpty && !password.isEmpty) {

            }else{
                showAlert()
            }
        }    }
    
}

extension AuthViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
    return true
    }
}
