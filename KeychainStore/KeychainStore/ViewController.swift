//
//  ViewController.swift
//  KeychainStore
//
//  Created by Rath! on 11/6/24.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate{
    
    let service = "com.example.app"
    private var account: String = "user123"
    
    
    
    
    let btnGet = UIButton(type: .system)
    let btnSave = UIButton(type: .system)
    let btnDelete = UIButton(type: .system)
    let containerStatk = UIStackView()
    
    

    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.backgroundColor = .lightGray
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .lightGray
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstrain()
    }
    
    private func setupConstrain(){
        
        let allView : [UIView] = [btnGet,btnSave,btnDelete,usernameTextField,passwordTextField]
        allView.forEach({ all in
            all.layer.cornerRadius = 10
            containerStatk.addArrangedSubview(all)
        })
        
        containerStatk.translatesAutoresizingMaskIntoConstraints = false
        containerStatk.axis = .vertical
        containerStatk.spacing = 10
        containerStatk.setCustomSpacing(50, after: btnDelete)
        containerStatk.distribution = .fill
        
        btnSave.setTitle("Save data", for: .normal)
        btnSave.backgroundColor = .blue
        btnSave.addTarget(self, action: #selector(tappedSave), for: .touchUpInside)
        btnSave.setTitleColor(.white, for: .normal)
        
        
        btnGet.setTitle("Get data", for: .normal)
        btnGet.backgroundColor = .gray
        btnGet.addTarget(self, action: #selector(tappedGet), for: .touchUpInside)
        btnGet.setTitleColor(.white, for: .normal)
        
        btnDelete.setTitle("Delete date", for: .normal)
        btnDelete.backgroundColor = .red
        btnDelete.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        btnDelete.setTitleColor(.white, for: .normal)
        
        view.addSubview(containerStatk)
        
        NSLayoutConstraint.activate([
            containerStatk.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerStatk.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            containerStatk.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            
            btnSave.heightAnchor.constraint(equalToConstant: 45),
            btnGet.heightAnchor.constraint(equalToConstant: 45),
            btnDelete.heightAnchor.constraint(equalToConstant: 45),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    // MARK: - UITextFieldDelegate
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else {
//            return true
//        }
//        
//        let textWithReplacement = (text as NSString).replacingCharacters(in: range, with: string)
//        textField.text = textWithReplacement
//        
//        // Adjust the text field's frame to accommodate the padding
//        textField.frame.origin.x = textFieldPadding
//        textField.frame.size.width = view.bounds.width - (2 * textFieldPadding)
//        
//        return false
//    }
}

//MARK: Even on button
extension ViewController{
    
    
    
    @objc func tappedSave(){
        account = usernameTextField.text ?? "r"
        let password = passwordTextField.text ?? "p"
        let data = password.data(using: .utf8)!
        
        if KeychainHelper.storeData(data: data, forService: service, account: account) {
            print("account \(account)")
            print("Data stored in Keychain successfully.")
        } else {
            print("account \(account)")
            print("Failed to store data in Keychain.")
        }
    }
    
    @objc func deleteData() {
        account = usernameTextField.text ?? ""
        if KeychainHelper.deleteData(forService: service, account: account) {
            print("account \(account)")
            print("Data deleted successfully from Keychain.")
        } else {
            print("account \(account)")
            print("Error deleting data from Keychain.")
        }
    }
    
    @objc func tappedGet() {
        account = usernameTextField.text ?? ""
        if let password = KeychainHelper.getData(forService: service, account: account) {
            print("account: \(account)")
            print("password: \(password)")
        } else {
            print("Error retrieving data from Keychain.")
        }
    }
}
