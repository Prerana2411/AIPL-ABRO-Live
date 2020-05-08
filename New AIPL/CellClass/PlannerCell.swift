//
//  PlannerCell.swift
//  AIPL
//
//  Created by apple on 08/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class PlannerCell: UITableViewCell {

    
    //MARK:- Variable
    //MARK:-
     let mainView = DropView()
    
    //MARK:- LifeCycle
    //MARK:-
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        //contentView.backgroundColor = CommonClass.sharedInstance.commonAppGrayColor
        
        addSubview(mainView)
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Configure UIComponent
    //MARK:-
    
    func configureComponent(){
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        mainView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        mainView.DropBtn.setImage(#imageLiteral(resourceName: "right_black"), for: .normal)
        mainView.MainView.layer.cornerRadius = 0
        mainView.MainView.backgroundColor = .clear
        mainView.MainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 5, height: CGFloat(CommonClass.sharedInstance.commonHeight))
        
        
    }
}
