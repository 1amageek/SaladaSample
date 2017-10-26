//
//  ItemsViewController.swift
//  SaladaSample
//
//  Created by nori on 2017/10/26.
//  Copyright © 2017年 1amageek. All rights reserved.
//

import UIKit
import Salada

class ItemsViewController: UITableViewController {

    var dataSource: DataSource<Item>?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Item list"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))

        let options: Options = Options()
        options.limit = 10
        self.dataSource = DataSource(reference: Item.databaseRef, options: options, block: { [weak self](changes) in
            guard let tableView: UITableView = self?.tableView else { return }

            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        })
    }

    @objc func add() {
        let item: Item = Item()
        item.name = "ITEM: " + UUID().uuidString
        item.save()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.dataSource?.objects[indexPath.item].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
