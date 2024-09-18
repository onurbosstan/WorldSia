//
//  Menu.swift
//  WorldSia
//
//  Created by Onur Bostan on 17.09.2024.
//

import UIKit

class Menu: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var choiseItem = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let screenWith = UIScreen.main.bounds.width
        self.view.frame = CGRect(x: screenWith, y:0, width: screenWith/2, height: UIScreen.main.bounds.height)
    }
    func showMenu() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.x = UIScreen.main.bounds.width/2
        }
    }
    func hideMenu() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.x = UIScreen.main.bounds.width
        }
    }
    @IBAction func closeButton(_ sender: Any) {
     hideMenu()
    }
}
extension Menu: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiseItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.choiceLabel.text = choiseItem[indexPath.row]
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
