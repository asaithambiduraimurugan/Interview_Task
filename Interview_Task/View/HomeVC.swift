//
//  HomeVC.swift
//  Interview_Task
//
//  Created by Asaithambi on 8/29/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var cat_Collection: UICollectionView!
    
    @IBOutlet weak var list_Collection: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}


extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == cat_Collection {
            
            return 1
            
        } else {
            
            return 3
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == cat_Collection {
            
            return 6
        } else {
            
            return 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == cat_Collection {
            
       let cell = cat_Collection.dequeueReusableCell(withReuseIdentifier: "HomeCatCell", for: indexPath) as! HomeCatCell

        return cell
            
        } else {
            
            let cell = list_Collection.dequeueReusableCell(withReuseIdentifier: "HomeListCell", for: indexPath) as! HomeListCell
            
            if indexPath.section == 0 {
     
            }
            
             return cell
            
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == cat_Collection {
            
            
            return CGSize(width: (CGFloat) (self.list_Collection.frame.size.width/3) ,height: (CGFloat) (self.cat_Collection.frame.size.height/2))
            
            
        } else{
            
            return CGSize(width: (CGFloat) (self.list_Collection.frame.size.width/3) ,height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

       
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigate_TO(id: "RecycleVCV")
    }
    
}
