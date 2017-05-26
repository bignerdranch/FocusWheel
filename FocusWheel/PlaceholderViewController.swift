//
//  PlaceholderViewController.swift
//  FocusWheel
//
//  Created by Nicholas Teissler on 5/25/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class PlaceholderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var tableView: UITableView!
    var cellColor: UIColor = UIColor.clear
    var browsing = true
    var hasFocus = false
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 190
        let menuRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuOut(sender:)))
        menuRecognizer.allowedPressTypes = [NSNumber(integerLiteral:UIPressType.menu.rawValue)]
        self.view.addGestureRecognizer(menuRecognizer)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.contentView.backgroundColor = cellColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return browsing || !hasFocus
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        browsing = context.nextFocusedIndexPath != nil
        hasFocus = context.nextFocusedIndexPath != nil
    }
    
    
    func menuOut(sender: UITapGestureRecognizer) {
        browsing = false
        setNeedsFocusUpdate()
    }
}
