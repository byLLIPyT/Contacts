//
//  ViewController.swift
//  Contacts
//
//  Created by Александр Уткин on 08.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var storage: ContactStorageProtocol!
    
    //private var contacts = [ContactProtocol]()
    var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
            storage.save(contacts: contacts)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()
    }
    
    private func loadContacts() {
        contacts = storage.load()
    }
    
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(title: "New contact", message: "Edit name and phone", preferredStyle: .alert)
        alertController.addTextField { (textFiled) in
            textFiled.placeholder = "name"
        }
        
        alertController.addTextField { (textFiled) in
            textFiled.placeholder = "phone"
        }
        
        let createButton = UIAlertAction(title: "Create", style: .default) { (_) in
            guard let contactName = alertController.textFields?[0].text, let phoneNumber = alertController.textFields?[1].text else { return }
            
            let contact = Contact(title: contactName, phone: phoneNumber)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = contacts[indexPath.row].title
        //configuration.attributedText = contacts[indexPath.row].phone
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
        return cell

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
    
}
