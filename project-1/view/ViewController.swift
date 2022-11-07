//
//  ViewController.swift
//  project-1
//
//  Created by melek türüdi on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    
    var userDetails: [UserDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        fetchUserData()
       // collectionView.collectionViewLayout = createLayout()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func fetchUserData() {
        let path = Bundle.main.path(forResource: "user-details", ofType: "json")
        let data = NSData(contentsOfFile: path ?? "") as Data?
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            if let aUserDetails = json["userDetails"] as? [[String : Any]] {
                for element in aUserDetails {
                    userDetails += [UserDetails(userDetails: element)]
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}


extension ViewController : UITableViewDataSource , UICollectionViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    as! TableViewCell
        cell.collectionView.tag = indexPath.section
        return cell
    }
    func tableView (_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat{
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return  1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
      
    }
}
