//
//  PiadaViewController.swift
//  ChuckNorris
//
//  Created by Junior Obici on 10/09/19.
//  Copyright © 2019 Junior Obici. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PiadaViewController: UIViewController {
    
    // MARK: - Variaveis
    var piada: Piada?
    let urlPiadas: String = "https://api.chucknorris.io/jokes/random?category="
    let urlPiadaAleatoria: String = "https://api.chucknorris.io/jokes/random"
    var categoriaSelecionada: String = ""
    typealias jsonStandard = [String : AnyObject]
    
    // MARK: - Componentes
    @IBOutlet weak var imagePiada: UIImageView!
    @IBOutlet weak var labelPiada: UILabel!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPiada(categoria: categoriaSelecionada)
        self.navigationItem.title = categoriaSelecionada.capitalized
    }
    
    // MARK: - Funcoes
    func loadPiada(categoria: String) {
        var url: String = ""
        if categoria != "" {
            url = self.urlPiadas+categoria
        } else {
            url = self.urlPiadaAleatoria
        }
        
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON(completionHandler: {(response) in
                let jsonData = response.data!
                do {
                    var JSON = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! jsonStandard
                    let piadaJson = Piada(categoria: ((JSON["categories"] as? [String])!), id: (JSON["id"] as? String)!, iconeUrl: (JSON["icon_url"] as? String)!, url: (JSON["url"] as? String)!, valor: (JSON["value"] as? String)!, dataInclusao: (JSON["created_at"] as? String)!, dataAtualizacao: (JSON["updated_at"] as? String)!)
                    self.piada = piadaJson
                    self.loadDados()
                } catch {
                    print (error.localizedDescription)
                }
            })
        }
    }
    
    func loadDados() {
        guard let iconeUrl = piada?.iconeUrl, let valor = piada?.valor else { return }
        getImage(urlImage: iconeUrl)
        self.labelPiada.text = valor
        self.activityLoading.stopAnimating()
    }
    
    func getImage(urlImage: String) {
        Alamofire.request(urlImage).responseImage { response in
            if let image = response.result.value {
                self.imagePiada.image = image
            } else {
                self.imagePiada.image = UIImage(named: "chuck-norris")
            }
        }
    }
}
