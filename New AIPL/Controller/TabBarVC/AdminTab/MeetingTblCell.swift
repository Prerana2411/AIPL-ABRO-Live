//
//  MeetingTblCell.swift
//  AIPL ABRO
//
//  Created by call soft on 05/05/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class MeetingTblCell: UITableViewCell {
    
    @IBOutlet weak var vw_bg: UIView!
    @IBOutlet weak var vw_joinMeet: UIView!
    @IBOutlet weak var btn_joinMeet: UIButton!
    @IBOutlet weak var lbl_meetDescr: UILabel!
    @IBOutlet weak var lbl_meetId: UILabel!
    @IBOutlet weak var lbl_meetPass: UILabel!
    @IBOutlet weak var lbl_schedule: UILabel!
    @IBOutlet weak var lbl_meetTime: UILabel!
    @IBOutlet weak var lbl_meetDate: UILabel!
    
     @IBOutlet weak var lbl_scheduleBy: UILabel!
    @IBOutlet weak var txt_descrp: UITextField!
    @IBOutlet weak var txt_meetId: UITextField!
    @IBOutlet weak var txt_meetPass: UITextField!
    @IBOutlet weak var txt_meetTime: UITextField!
    @IBOutlet weak var txt_meetDate: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
