//
//  Productrtesponce.swift
//  Interview_Task
//
//  Created by Asaithambi on 8/30/23.
//

import Foundation


class ProductsResponseModel {


        var name: String!
        var image: String!


    init(data : NSDictionary) {

         if let name = data["login"]{
            self.name = name as? String
        }

        if let image = data["avatar_url"]{
           self.image = image as? String
       }

    }
}


//struct ProductsResponseModel: Decodable {
//    // Properties in your model
//    let name: String
//    let Img: String
//    // ...
//    
//    // Implement the init(from:) initializer
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        Img = try container.decode(String.self, forKey: .Img)
//        // Decode other properties here
//    }
//    
//    // Coding keys for your properties
//    enum CodingKeys: String, CodingKey {
//        case name
//        case Img
//        // Define other coding keys for your properties
//    }
//}

import Foundation

struct Products:Decodable{
    let name: Int
    let Img: Int
   
    
}


struct productresponse: Decodable {
    
    let result :[Products]
}

