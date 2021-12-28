//
//  AddEditConsoleViewController.swift
//  MyGames
//
//  Created by aluno on 27/12/21.
//

import UIKit
import Photos

class AddEditConsoleViewController: UIViewController {

    
    var console: Console?
    

    @IBOutlet weak var tfConsole: UITextField!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btAddCover: UIButton!
    @IBOutlet weak var ivCoverConsole: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adicionar Console"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareDataLayout()
    }
    
    func prepareDataLayout() {
        if console != nil {
            title = "Adicionar Console"
            btAddEdit.setTitle("ALTERAR", for: .normal)
            tfConsole.text = console?.name
            
  
            ivCoverConsole.image = console?.coverConsole as? UIImage
            if console?.coverConsole != nil {
                btAddCover.setTitle("", for: .normal)
            }
        }

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    
    @IBAction func AddEditCover(_ sender: UIButton) {
            // para adicionar uma imagem da biblioteca
        print("obter uma imagem da galeria")
        
        let alert = UIAlertController(title: "Selecinar console", message: "De onde você quer escolher o console?", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func addEditConsole(_ sender: UIButton) {
            // acao salvar novo ou editar existente
        print("SALVAR")
        
        if console == nil {
            console = Console(context: context)
        }
        console?.name = tfConsole.text

        console?.coverConsole = ivCoverConsole.image
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
            // Back na navigation
        navigationController?.popViewController(animated: true)
    }
    
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        
            //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    
                    self.chooseImageFromLibrary(sourceType: sourceType)
                    
                } else {
                    
                    print("unauthorized -- TODO message")
                }
            })
        } else if photos == .authorized {
            
            self.chooseImageFromLibrary(sourceType: sourceType)
        } else if photos == .denied {
            print("notificar o usuario que nao temos permissao de acessar a galeria e sugerir para o usuario acessar a tela de configuracao para habiltiar novamente a sua app. Podemos colocar um link aqui para o usuario ir direto")
        }
    }
    
    func chooseImageFromLibrary(sourceType: UIImagePickerController.SourceType) {
        
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.navigationBar.tintColor = UIColor(named: "main")
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    

} // fim da classe


extension AddEditConsoleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ConsolesManager.shared.consoles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let console = ConsolesManager.shared.consoles[row]
        return console.name
    }
}


extension AddEditConsoleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        // tip. implementando os 2 protocols o evento sera notificando apos user selecionar a imagem
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
                // ImageView won't update with new image
                // bug fixed: https://stackoverflow.com/questions/42703795/imageview-wont-update-with-new-image
            DispatchQueue.main.async {
                self.ivCoverConsole.image = pickedImage
                self.ivCoverConsole.setNeedsDisplay()
                self.btAddCover.setTitle("", for: .normal)
                self.btAddCover.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    

}
