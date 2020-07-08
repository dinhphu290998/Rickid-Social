//
//  SearchViewController.swift
//  Me
//
//  Created by NDPhu on 7/8/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import LGButton

class SearchViewController: UIViewController {

    var listSearch = [Search]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listSearch = fetchListSearch()
        tableView.reloadData()
    }
    func fetchListSearch() -> [Search] {
        return RealmService.shared.getObjects(type: Search.self) ?? []
    }

    @IBAction func back(_ sender: LGButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchAndSaveToRealm(_ sender: UIButton) {
        let searchString = Search.init()
        searchString.searchString = searchTextField.text ?? ""
        RealmService.shared.saveObject(objs: searchString)
        self.listSearch = fetchListSearch()
        tableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listSearch[indexPath.row].searchString
        return cell
    }
    
    
}
