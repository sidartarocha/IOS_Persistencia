//
//  ConsoleViewController.swift
//  MyGames
//
//  Created by aluno on 27/12/21.
//

import UIKit

class ConsoleViewController: UIViewController {

    var console: Console?
    
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var ivCoverConsole: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        lbConsole.text = console?.name
        
        if let image = console?.coverConsole as? UIImage {
            ivCoverConsole.image = image
        } else {
            ivCoverConsole.image = UIImage(named: "noCoverFull")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? AddEditConsoleViewController {
            vc.console = console
        }
    }


}
