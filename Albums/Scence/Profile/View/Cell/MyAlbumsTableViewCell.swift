//
//  MyAlbumsTableViewCell.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import UIKit

class MyAlbumsTableViewCell: UITableViewCell {
    // MARK:  Vars
    static let ID = String(describing: MyAlbumsTableViewCell.self)
    
    // MARK:  @IBOutlet
    @IBOutlet weak var AlbumNameLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK:   Make Configure Cell
    func configureCell(_ tableData: AlbumsModel) {
        AlbumNameLab.text = tableData.title
    }
    
}
