//
//  FriendsCollectionViewController.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 28.09.2020.
//

import UIKit

//private let reuseIdentifier = "currentImage"

class FriendsCollectionViewController: UICollectionViewController {

    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ImageCell
        
        cell.selectedImage.image = selectedImage
        
        return cell
    }
}
