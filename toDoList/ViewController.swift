//
//  ViewController.swift
//  toDoList
//
//  Created by Мира Зейнурова on 10.02.2023.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var fetchresultController = NSFetchedResultsController<NSFetchRequestResult>()
    let coreDataManager = CoreDataManager.shared
   
    
    var itemsTable: UITableView = {
    var table = UITableView()
    return table
    }()
    
    var addButton: UIButton = {
    var button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        return button
        }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //title didn't appear in view
        self.title = "My To Do List"
        self.navigationController?.navigationBar.barTintColor = .cyan
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
               UINavigationBar.appearance().isTranslucent = false
               UINavigationBar.appearance().barTintColor = .systemRed
               

   
        fetchresultController = coreDataManager.getResultContainer(entityName: "ToDoListItem", sortingKey: "name")
        
        do {
            try fetchresultController.performFetch()
        } catch {
            print(error)
        }
        
        fetchresultController.delegate = self
        
        view.addSubview(itemsTable)
        itemsTable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(840)
            make.trailing.equalToSuperview().offset(-10)
        }

        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }

        itemsTable.register(TableViewCell.self, forCellReuseIdentifier: "myCell")
        itemsTable.dataSource = self
        itemsTable.delegate = self
        
    }
    
    @objc func addAction() {
        self.present(SecondViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchresultController.sections![section].numberOfObjects
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemsTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as?
        TableViewCell else { return UITableViewCell()}
         let item = fetchresultController.object(at: indexPath) as? ToDoListItem
         cell.deadlineLabel.text = item!.deadline
         cell.actionLabel.text = item!.name
         return cell
     }
    
    //error with deleting the rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            itemsTable.deleteSections(, with: true)
        }
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        itemsTable.beginUpdates()
    }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                itemsTable.insertRows(at: [indexPath], with: .automatic)
            }
        default :
            print("sdfsfd")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        itemsTable.endUpdates()
    }
    
}



