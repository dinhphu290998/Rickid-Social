//
//  VideoManagerViewController.swift
//  Me
//
//  Created by NDPhu on 7/7/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoManagerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var count = 10

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        self.tableView.reloadData()
    }

}
