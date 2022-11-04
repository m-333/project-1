//
//  ViewController.swift
//  project-1
//
//  Created by melek türüdi on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
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
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
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

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
  func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return userDetails.count
    }
    
     func tableView (tableView: UITableView, numberOfRowsSection section : Int) -> Int {
        return userDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostTableViewCell

        return cell
    }
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {

        guard let tableViewCell = cell as? PostTableViewCell else { return }

       // tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! usersCollectionViewCell
            cell.imgView.imageFromServerURL(userDetails[indexPath.row].imageUrl)
            cell.lblUserName.text = userDetails[indexPath.row].name
            return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.pages = self.userDetails
            vc.currentIndex = indexPath.row
            self.present(vc, animated: true, completion: nil)
        }
    }
}
