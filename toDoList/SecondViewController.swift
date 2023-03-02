//
//  SecondViewController.swift
//  toDoList
//
//  Created by Мира Зейнурова on 10.02.2023.
//

import UIKit

class SecondViewController: UIViewController {
    let coreDataManager = CoreDataManager.shared
    
    
    let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Add some actions"
        textfield.borderStyle = .roundedRect
        textfield.textColor = .black
        return textfield
    }()
    
    let dateTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Pin your deadline"
        textfield.borderStyle = .roundedRect
        textfield.textColor = .black
        return textfield
    }()
    
    let actionIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "action")
        return image
    }()
    
    let dateIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "calendar")
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.604, green: 0.799, blue: 0.979, alpha: 1)
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(110)
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(actionIcon)
        actionIcon.snp.makeConstraints { make in
            make.leading.equalTo(nameTextField).offset(-50)
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        
        view.addSubview(dateTextField)
        dateTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(110)
            make.top.equalToSuperview().offset(230)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(dateIcon)
        dateIcon.snp.makeConstraints { make in
            make.leading.equalTo(dateTextField).offset(-50)
            make.top.equalToSuperview().offset(230)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(160)
            make.top.equalToSuperview().offset(300)
            make.width.equalTo(80)
            make.height.equalTo(28)
        }
        
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(340)
            make.leading.equalTo(158)
            make.width.equalTo(80)
            make.height.equalTo(28)
        }
        
    }
    @objc func save() {
        if nameTextField.text?.isEmpty == true ||  ((dateTextField.text!.isEmpty) == true) {
            
            let alert = UIAlertController(title: "Error", message: "Fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        } else {
            guard let name = nameTextField.text else { return }
            guard let date = dateTextField.text else { return }
          
            coreDataManager.createObject(name: name, deadline: date)
            
            dismiss(animated: true)
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }

}
