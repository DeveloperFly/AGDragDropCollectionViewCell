//
//  ViewController.swift
//  AGDragDropCollectionViewCell
//
//  Created by Aman Gupta on 28/12/17.
//  Copyright © 2017 Developer Fly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutelets
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    //MARK: - Variables
    var arrayFirst = ["File1.jpeg", "File2.jpg", "File3.jpeg", "File4.jpg", "File5.jpeg", "File6.jpg", "File7.jpg", "File8.jpeg", "File9.jpeg", "File10.jpeg", "File11.jpg", "File12.jpg"  ]
    var arraySecond = ["File1.jpeg", "File2.jpg", "File3.jpeg", "File4.jpg"]

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return arrayFirst.count
        } else {
            return arraySecond.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell", for: indexPath) as! TopCollectionViewCell
            cell.configureCell(image: UIImage(named: arrayFirst[indexPath.row])!)
            return cell
        } else if collectionView == self.bottomCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath) as! BottomCollectionViewCell
            cell.configureCell(image: UIImage(named: arraySecond[indexPath.row])!)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.topCollectionView {
            return CGSize(width: 100, height: 100)
        } else if collectionView == self.bottomCollectionView {
            return CGSize(width: (bottomCollectionView.frame.width / 3 - 20), height: (bottomCollectionView.frame.width / 3 - 20))
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
}

