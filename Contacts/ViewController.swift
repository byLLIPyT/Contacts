//
//  ViewController.swift
//  Contacts
//
//  Created by Александр Уткин on 08.06.2021.
//

import UIKit

class ViewController: UIViewController {

    private var contacts = [ContactProtocol]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "Alex", phone: "365-65-65"))
        contacts.append(Contact(title: "Ann", phone: "+7-919-375-74-06"))
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
