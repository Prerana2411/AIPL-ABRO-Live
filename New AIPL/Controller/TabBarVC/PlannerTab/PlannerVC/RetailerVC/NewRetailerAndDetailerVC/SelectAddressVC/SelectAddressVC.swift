//
//  SelectAddressVC.swift
//  AIPL ABRO
//
//  Created by CST on 24/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit
import MapKit

class SelectAddressVC: UIViewController , UISearchBarDelegate {
  

    //MARK:- Variable
    //MARK:-
    
    lazy var searchBtn : UIButton = {
        
        let btn = UIButton()
        if #available(iOS 13.0, *) {
            btn.setImage(UIImage(contentsOfFile: "magnifyingglass"), for: .normal)
            
        }
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.1172581986, green: 0.5608307719, blue: 0.9606644511, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: CommonClass.sharedInstance.MediumFont, size: CommonClass.sharedInstance.semiBoldfontSize)
        return btn
    }()
    
    lazy var mapView:MKMapView = {
        
        let view = MKMapView()
        
        return view
        
    }()
    
    lazy var transView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
        
    }()
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearch.Request!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearch.Response!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var delegate : SelectAddressVCDelegate?
    
    //MARK:- LifeCycle
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setConstriant()
    }
   
    //MARK:- Set Constraint
    //MARK:-
    
    func setConstriant(){
        
        view.backgroundColor = .clear
        self.navigationController?.isNavigationBarHidden = true
        
        view.addSubview(transView)
        view.addSubview(mapView)
        view.addSubview(searchBtn)
        
        transView.scrollAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mapView.popup(inView:view,width:view.frame.width - 40,height:view.frame.height - 150)
        mapView.layer.cornerRadius = 8
        
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([searchBtn.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10),
                                     searchBtn.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -10),
                                     searchBtn.heightAnchor.constraint(equalToConstant: 30)])
        
         searchBtn.addTarget(self, action: #selector(seachBtnClick), for: .touchUpInside)
        
         let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 34.03, longitude: 118.14)
         
         let span = MKCoordinateSpan.init(latitudeDelta: 100, longitudeDelta: 80)
         let region = MKCoordinateRegion.init(center: coordinate, span: span)
         self.mapView.setRegion(region, animated: true)
        
    
    }
    
    
    @objc func seachBtnClick(sender:UIButton){
        
        sender.isHidden = true
        searchController = UISearchController(searchResultsController: nil)
               searchController.hidesNavigationBarDuringPresentation = false
               self.searchController.searchBar.delegate = self
               present(searchController, animated: true, completion: nil)
               
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.searchBtn.isHidden = false
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            print( self.pointAnnotation.coordinate)
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            self.searchBtn.isHidden = false
            
            
            self.dismiss(animated: false) {
                self.delegate?.address(text: self.pointAnnotation.title ?? "", lat: String(self.pointAnnotation.coordinate.latitude), long: String(self.pointAnnotation.coordinate.longitude))
            }
             
            
        }
    }
}
