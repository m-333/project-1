//
//  PostTableViewCell.swift
//  project-1
//
//  Created by melek türüdi on 4.11.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var userDetails: [UserDetails] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fetchUserData()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    extension PostTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
      func collectionView(_ collectionView: UICollectionView,
                            numberOfItemsInSection section: Int) -> Int {
            return userDetails.count
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
}
