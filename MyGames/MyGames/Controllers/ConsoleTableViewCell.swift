//
//  ConsoleTableViewCell.swift
//  MyGames
//
//  Created by aluno on 27/12/21.
//

import UIKit

class ConsoleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbConsole: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with console: Console) {
        lbConsole.text = console.name ?? ""
        if let image = console.coverConsole as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCover")
        }
    }
}
