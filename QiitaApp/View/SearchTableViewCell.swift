//
//  SearchTableViewCell.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/03.
//

import UIKit

protocol SearchTableViewCellDelegate: class {
    func deleteCellAction()
}

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    var cellDone: (()->Void)?
    

    weak var delegate: SearchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        cellDone?()
        delegate?.deleteCellAction()
    }
    
}
