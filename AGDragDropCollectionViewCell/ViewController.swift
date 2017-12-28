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
        topCollectionView?.dragDelegate = self
        topCollectionView.dragInteractionEnabled = true
        bottomCollectionView.dropDelegate = self
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

//MARK: - UICollectionViewDragDelegate
extension ViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = self.dragItem(forPhotoAt: indexPath)
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let dragItem = self.dragItem(forPhotoAt: indexPath)
        return [dragItem]
    }

    /// Helper method
    private func dragItem(forPhotoAt indexPath: IndexPath) -> UIDragItem {
        let imageName = self.arrayFirst[indexPath.row]
        let itemProvider = NSItemProvider(object: imageName as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = imageName
        return dragItem
    }
    
}

extension ViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {

        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        loadAndInsertItems(at: destinationIndexPath, with: coordinator)
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
    
    private func loadAndInsertItems(at destinationIndexPath: IndexPath, with coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = bottomCollectionView.numberOfSections - 1
            let row = bottomCollectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            guard let string = items as? [String] else { return }
            
            var indexPaths = [IndexPath]()
            
            for (index, value) in string.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.arraySecond.insert(value, at: indexPath.row)
                indexPaths.append(indexPath)
            }
            self.bottomCollectionView.insertItems(at: indexPaths)
        }
    }
    
}
