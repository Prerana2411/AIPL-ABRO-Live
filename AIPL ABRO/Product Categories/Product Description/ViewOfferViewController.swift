//
//  ViewOfferViewController.swift
//  AIPL ABRO
//
//  Created by Sourabh Mittal on 22/02/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class ViewOfferViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK: Outlets
    
    @IBOutlet weak var viewOffer_CollectionView: UICollectionView!
    
    @IBOutlet weak var image_pageControl: UIPageControl!

    @IBOutlet weak var descriptionOuterView_View: UIView!
    
    @IBOutlet weak var descriptionInnerView_View: UIView!
    
    @IBOutlet weak var minus_ImageView: UIImageView!
    
    @IBOutlet weak var descriptionHeading_label: UILabel!
    
    @IBOutlet weak var description_label: UILabel!
    
    var offerDetail : NSDictionary = [:]
    
    var rewardOrDiscount = ""
    
    var imageCount = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        if self.offerDetail.count == 0{
            
            
        }else{
            
            
            if rewardOrDiscount == "Reward"{
                
                self.description_label.text = String(describing:(self.offerDetail.value(forKey: "description"))!)
                
                //////
                descriptionOuterView_View.layer.masksToBounds = true
                
                descriptionOuterView_View.layer.cornerRadius = 8
                
                descriptionOuterView_View.giveShadow(Outlet: descriptionOuterView_View)
                
                descriptionInnerView_View.layer.masksToBounds = true
                
                descriptionInnerView_View.layer.cornerRadius = 8
                
                descriptionInnerView_View.giveShadowinnerview(Outlet: descriptionInnerView_View)
                
                if (self.offerDetail.value(forKey: "particularProductRewardOfferImagee") as! NSArray).count == 0{
                    
                    
                }else{
                    
                    self.imageCount = (self.offerDetail.value(forKey: "particularProductRewardOfferImagee") as! NSArray).count
                    
                    self.viewOffer_CollectionView.delegate = self
                    
                    self.viewOffer_CollectionView.dataSource = self
                    
                    self.viewOffer_CollectionView.reloadData()
                }
                
            }
            
            if rewardOrDiscount == "Discount"{
                
                self.description_label.text = String(describing:(self.offerDetail.value(forKey: "description"))!)
                
                //////
                descriptionOuterView_View.layer.masksToBounds = true
                
                descriptionOuterView_View.layer.cornerRadius = 8
                
                descriptionOuterView_View.giveShadow(Outlet: descriptionOuterView_View)
                
                descriptionInnerView_View.layer.masksToBounds = true
                
                descriptionInnerView_View.layer.cornerRadius = 8
                
                descriptionInnerView_View.giveShadowinnerview(Outlet: descriptionInnerView_View)
                
                if (self.offerDetail.value(forKey: "particularProductvoucherimage") as! NSArray).count == 0{
                    
                    
                }else{
                    
                    self.imageCount = (self.offerDetail.value(forKey: "particularProductvoucherimage") as! NSArray).count
                    
                    self.viewOffer_CollectionView.delegate = self
                    
                    self.viewOffer_CollectionView.dataSource = self
                    
                    self.viewOffer_CollectionView.reloadData()
                }
                
            }
            
        }
        
        
        self.image_pageControl.numberOfPages = self.imageCount
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = "Current Offer"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.offerDetail = [:]
        
        self.imageCount = 0
        
    }
    
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
            image_pageControl.currentPage = indexPath.row
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
            return CGSize(width : viewOffer_CollectionView.frame.width  , height: viewOffer_CollectionView.frame.height )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //    return ((self.myData.value(forKey: "all_images") as? NSArray)!.count)
    
        return self.imageCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = viewOffer_CollectionView.dequeueReusableCell(withReuseIdentifier: "viewOffer_Identifier", for: indexPath) as! ViewOfferCollectionViewCell
        
        if  ((((self.offerDetail.value(forKey: "particularProductvoucherimage") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  (((self.offerDetail.value(forKey: "particularProductvoucherimage") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") ) is NSNull{
            
            cell.offerImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
            
        }else{
            
            cell.offerImage_ImageView.setImageWith((NSURL(string : comboImage_url + (((self.offerDetail.value(forKey: "particularProductvoucherimage") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
            
        }
        
        /*
            if  ((((self.myData.value(forKey: "all_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) == "<null>" ||  (((self.myData.value(forKey: "all_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image")) is NSNull{
                
                cell.productImage_ImageView.image = #imageLiteral(resourceName: "placeholder")
                
            }else{
                
                cell.productImage_ImageView.setImageWith((NSURL(string : productImage_url + (((self.myData.value(forKey: "all_images") as? NSArray)?.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "image") as? String)!) as URL?)! ,placeholderImage: #imageLiteral(resourceName: "placeholder"))
                
            }
         */
            return cell
            
        
            
            
        }
    
}
