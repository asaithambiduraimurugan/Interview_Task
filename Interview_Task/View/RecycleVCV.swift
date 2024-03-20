//
//  RecycleVCV.swift
//  Interview_Task
//
//  Created by Asaithambi on 8/30/23.
//

import UIKit
import Alamofire


class RecycleVCV: UIViewController {

    var apiResult = [Model]()
 
    
    
    @IBOutlet weak var Recycle_Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       fetchAPIData()
        

  
    }
     
    func fetchAPIData() {
        
        
       let url = "https://api.github.com/users"
        
        let params  = ["since":2,"per_page": 30] as [String : Any]
        
       AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil, interceptor: nil)
         .response{ resp in
       
             switch resp.result{
                 
               case .success(let data):
                 
                 do{
                     
                   let jsonData = try JSONDecoder().decode([Model].self, from: data!)
                     
                   print(jsonData)
                     
                     self.apiResult = jsonData
                     
                     DispatchQueue.main.async {
                         
                        self.Recycle_Table.reloadData()
                    }
                     
                } catch {
                   print(error.localizedDescription)
                }
              case .failure(let error):
                print(error.localizedDescription)
              }
         }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(url: URL, IMG: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                IMG.image = UIImage(data: data)
         
                
            }
            
            
        }
    }
   

}





extension RecycleVCV : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return apiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "RecycleCell", for: indexPath) as! RecycleCell

        let img = apiResult[indexPath.row].avatar_url
        let Url = URL(string: img)!
        downloadImage(url: Url, IMG: cell.cell_IMG)
        
         //cell.cell_IMG.setKFImage(with: imgurl)

        cell.name_Lbl.text = "\(apiResult[indexPath.row].login)"
         
         return cell
        
    }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
      return 140
      
  }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigate_TO(id: "WebVC")
      
        
    }
    
    
    
}




