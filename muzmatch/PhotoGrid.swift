//
//  PhotosGrid.swift
//  muzmatch
//

import UIKit
import Photos
import Foundation

class PhotoGridController : UICollectionViewController {
    
    //ray wenderleich's tutorial put this up here. it's just an ID from the Storyboard and it references the UICollectionViewCells.
    let reuseIdentifier = "photoCell"
    
    //empty model for our CollectionView. we'll initialize and use this later on.
    var dataObject: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //read emoji file and populate model.
        dispatch_async(dispatch_get_main_queue(), {self.getPhotos()})
    }
    
    
    func getPhotos(){
        let PhotoArray = NSBundle.mainBundle().pathsForResourcesOfType("jpg", inDirectory: "photos");
        
        PhotoArray.forEach({
            dataObject.append(UIImage(named: $0, inBundle: nil, compatibleWithTraitCollection: nil)!);
        });
        
        self.collectionView?.reloadData();
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataObject.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //make a cell. we extended UICollectionViewCell to access the imageView.
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCellController
        
        //set up the imageView for this cell.
        let image = dataObject[indexPath.row]
        
        cell.imageView.image = image;
        
        let cellWidth = self.collectionView!.frame.width;
        let cellHeight = self.collectionView!.frame.height;
        
        cell.imageWidth.constant = cellWidth;
        cell.imageHeight.constant = cellHeight;
        
        return cell
    }
    
}


extension PhotoGridController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            let cellWidth = self.collectionView!.frame.width;
            let cellHeight = self.collectionView!.frame.height;
            
            print(cellWidth, cellHeight);
            
            return CGSize(width: cellWidth, height: cellHeight);
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
    }
}
