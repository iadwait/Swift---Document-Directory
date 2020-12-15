//
//  ViewController.swift
//  Document Directory Save Get Image
//
//  Created by Adwait Barkale on 15/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet var collectionView: UICollectionView!
    
    var arrImages = [
        "Favorite.png",
        "contact.png",
        "cplus.png"
    ]
    
    var arrUrl = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        //saveImages()
        //saveMultipleImages()
        subFolderStoreTest()
    }
    
    func saveImages()
    {
        let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(document)
        
        let imgUrl = document.appendingPathComponent("Favorite.png", isDirectory: true)
        print("Image Url - \(imgUrl.path)")
        
        if !FileManager.default.fileExists(atPath: imgUrl.path)
        {
            do{
                try (UIImage(named: "Favorite.png"))!.pngData()!.write(to: imgUrl)
                print("Image Added Successfully")
            }catch{
                print("Image Not Added")
            }
        }
        
        //imgView.image = UIImage(contentsOfFile: imgUrl.path)
    }
    
    func saveMultipleImages()
    {
        for strImage in arrImages{
            
            let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            print(document)
            
            let imgUrl = document.appendingPathComponent(strImage, isDirectory: true)
            print("Image Url - \(imgUrl.path)")
            
            if !FileManager.default.fileExists(atPath: imgUrl.path)
            {
                do{
                    try (UIImage(named: strImage))!.pngData()!.write(to: imgUrl)
                    print("Image \(strImage) Added Successfully")
                }catch{
                    print("Image Not Added")
                }
            }
            
            arrUrl.append(imgUrl)
        }
    }
    
    func subFolderStoreTest()
    {
        let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(document)
        
        let imagesDir = document.appendingPathComponent("Images", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: imagesDir.path)
        {
            do{
                try FileManager.default.createDirectory(at: imagesDir, withIntermediateDirectories: true, attributes: nil)
            }catch let err{
                print("Error Creating Images Directory - \(err)")
            }
        }else{
            print("Images Directory Already Created")
        }
        
        
        for strImage in arrImages
        {
            let imgUrl = imagesDir.appendingPathComponent(strImage, isDirectory: true)
            
            if !FileManager.default.fileExists(atPath: imgUrl.path)
            {
                do{
                    try UIImage(named: strImage)?.pngData()?.write(to: imgUrl)
                    print("Image Data Wirte Success")
                    arrUrl.append(imgUrl)
                }catch let err{
                    print("Error Writing Image Data - \(err)")
                }
            } else {
                print("\(strImage) Data is Already Added")
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        cell.imgView.image = UIImage(contentsOfFile: arrUrl[indexPath.row].path)
        return cell
    }
    
}

class myCollectionViewCell : UICollectionViewCell
{
    
    @IBOutlet var imgView: UIImageView!
    
    
}
