//
//  FilteredTableViewCell.swift
//  BookOnTheTable
//
//  Created by administrator on 06/04/21.
//

import UIKit

class FilteredTableViewCell: UITableViewCell {

    lazy var backView: UIView = {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        return backView
    }()
    
    lazy var lbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: 0, width: self.frame.width - 80, height: 40))
        return lbl
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(lbl)
    }

}
