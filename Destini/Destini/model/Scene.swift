//
//  Scene.swift
//  Destini
//
//  Created by Surya Chundru on 22/03/18.
//  Copyright © 2018 Apollo App Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

class Scene {
    let id: Int
    let description: String
    let optionText: String
    var choices = [Scene]()
    
    init(id: Int, description: String, optionText: String) {
        self.id = id
        self.description = description
        self.optionText = optionText
    }
    
    func getNext(forChoice: Int) -> Scene {
        if (forChoice < choices.count) {
            return choices[forChoice]
        } else {
            return self
        }
    }
}

extension Scene {
    class func deserialize (fromJSONFile: String) -> Scene? {
        print("Deserializing...")
        if let path = Bundle.main.path(forResource: "story", ofType: "json") {
            do {
                var scenes = [Int:Scene]()
                var firstSceneId = 10000
                var sceneDependencies = [Int:[Int]]()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                for sceneJSON in jsonObj["scenes"].arrayValue {
                    let id = sceneJSON["sceneId"].intValue
                    if firstSceneId > id {
                        firstSceneId = id
                    }
                    let desc = sceneJSON["description"].stringValue
                    let optionText = sceneJSON["optionText"].stringValue
                    var choices = [Int]()
                    for choiceId in sceneJSON["choices"].arrayValue {
                        choices.append(choiceId.intValue)
                    }
                    choices.sort()
                    sceneDependencies.updateValue(choices, forKey: id)
                    scenes.updateValue(Scene(id: id, description: desc, optionText: optionText), forKey: id)
                }
                
                for sceneInfo in scenes {
                    for choiceId in sceneDependencies[sceneInfo.key]! {
                        sceneInfo.value.choices.append(scenes[choiceId]!)
                    }
                }
                print(scenes)
                print(firstSceneId)
                return scenes[firstSceneId]
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        
        return nil
    }
}
