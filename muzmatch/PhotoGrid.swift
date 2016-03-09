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
    
    
    //i have to do this because I don't understand AutoLayout. Fuck autolayout.
    func setControlContainerSize(notification: NSNotification) {
        var frame: CGRect = self.view.frame
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        let delta = notification.object as! CGFloat
        
        print("Setting control container size...")
        //        print(screenHeight - delta)
        
        frame.size.height = screenHeight - delta
        frame.size.width = UIScreen.mainScreen().bounds.width
        
        self.view.frame = frame
        self.collectionView?.frame = frame
    }
    
    func scrollToTopControlContainer() {
        self.collectionView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\nhello world (EmojiGrid)")
        
        //read emoji file and populate model.
        dispatch_async(dispatch_get_main_queue(), {self.getPhotos()})
        
        print("\nEnd of EmojiGrid viewDidLoad")
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
    
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        //        print("\nSelected:")
//        //        print(indexPath.row)
//        
//        NSNotificationCenter.defaultCenter().postNotificationName("emojiChosen", object: dataObject[indexPath.row])
//        
//    }
    
}


extension PhotoGridController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            let cellWidth = self.collectionView!.frame.width;
            let cellHeight = self.collectionView!.frame.height;
            
//            cellWidth = 100;
//            cellHeight = 100;
            
            print(cellWidth, cellHeight);
            
            return CGSize(width: cellWidth, height: cellHeight);
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
    }
}