//
//  CategoriaViewController.swift
//  ChuckNorris
//
//  Created by Junior Obici on 10/09/19.
//  Copyright © 2019 Junior Obici. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoriaViewController: UIViewController {
    
    // MARK: - Variaveis
    var categoria: [Categoria] = []
    let urlCategorias: String = "https://api.chucknorris.io/jokes/categories"
    typealias jsonStandard = [String : AnyObject]
    
    // MARK: - Componentes
    @IBOutlet weak var tablePiadas: UITableView!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategorias()
    }
    
    // MARK: - Funcoes
    func loadCategorias(){
        DispatchQueue.main.async {
            Alamofire.request(self.urlCategorias).responseJSON(completionHandler: {(response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        json.array?.forEach({ (cat) in
                            let categoriaJson = Categoria(categoria: cat.stringValue)
                            self.categoria.append(categoriaJson)
                        })
                        self.activityLoading.stopAnimating()
                        self.tablePiadas.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePiada" {
            let vc: PiadaViewController = segue.destination as! PiadaViewController
            let indexPath = tablePiadas.indexPathForSelectedRow!
            let currentCellValue = tablePiadas.cellForRow(at: indexPath)! as UITableViewCell
            let textLabelText = currentCellValue.textLabel!.text?.lowercased()
            vc.categoriaSelecionada = textLabelText!
            self.tablePiadas.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - Extensions
extension CategoriaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = categoria[indexPath.row].categoria.capitalized
        return cell!
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
