//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
    let mainView = ProfileImageView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        
        navigationController?.setNavigationBar()

    }
}


extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        Constants.Mock.ProfileImages.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        let image = UIImage(named: Constants.Mock.ProfileImages.profileImageList[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.imageButton.setImage(image, for: .normal)
        
        cell.imageButton.tag = indexPath.item + 1
        
        if UserDefaultsManager.shared.image == "profile\(cell.imageButton.tag)" {
            cell.imageButton.circleBorder()
        } else {
            cell.imageButton.circle()
        }
            
        cell.imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func imageButtonTapped(sender: UIButton) {
        UserDefaultsManager.shared.image = "profile\(sender.tag)"
        mainView.collectionView.reloadData()
        mainView.imageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }
    

}
