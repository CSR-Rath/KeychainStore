//
//  ViewController.swift
//  KeychainStore
//
//  Created by Rath! on 11/6/24.
//

import UIKit


class ViewController: UIViewController {
    
    let service = "com.example.app"
    let account = "user123"
    
    
    
    let btnGet = UIButton(type: .system)
    let btnSave = UIButton(type: .system)
    let btnDelete = UIButton(type: .system)
    let containerStatk = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allView : [UIView] = [btnGet,btnSave,btnDelete]
        allView.forEach({ all in
            all.layer.cornerRadius = 10
            containerStatk.addArrangedSubview(all)
        })
        
        containerStatk.translatesAutoresizingMaskIntoConstraints = false
        containerStatk.axis = .vertical
        containerStatk.spacing = 10
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
        
        setupConstrain()
    }
    
    
    private func setupConstrain(){
        
       
        view.addSubview(containerStatk)
        
        
        NSLayoutConstraint.activate([
            containerStatk.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerStatk.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            containerStatk.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            
            btnSave.heightAnchor.constraint(equalToConstant: 45),
            btnGet.heightAnchor.constraint(equalToConstant: 45),
            btnDelete.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    @objc func tappedSave(){
        let password = "mySecretPassword"
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
        if KeychainHelper.deleteData(forService: service, account: account) {
            print("account \(account)")
            print("Data deleted successfully from Keychain.")
        } else {
            print("account \(account)")
            print("Error deleting data from Keychain.")
        }
    }
    
    
    @objc func tappedGet() {
        if let password = KeychainHelper.getData(forService: service, account: account) {
            print("status: success")
            print("password: \(password)")
        } else {
            print("Error retrieving data from Keychain.")
        }
    }
}
