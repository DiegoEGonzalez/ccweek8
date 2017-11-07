//
//  GameViewController.swift
//  many things
//
//  Created by Diego E Gonzalez on 11/6/17.
//  Copyright © 2017 Diego E Gonzalez. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    var scene: SCNScene!
    
    var materials: [SCNMaterial]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
       let mat = SCNMaterial();
        mat.diffuse.contents = NSColor.blue
        mat.isLitPerPixel = false;
        ship.geometry?.materials = [mat]
        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = NSColor.black
        manythings()
    }
    
    func manythings(){
        loadMaterials()
        for index in 1...9{
            let random = arc4random_uniform(10)
            let geometry = SCNSphere(radius: CGFloat(random))
            geometry.firstMaterial = materials[index-1]
            
            let obj = SCNNode(geometry: geometry)
        
            obj.position.x = CGFloat(index * 20);
            scene.rootNode.addChildNode(obj)
        }
    }
    
    func loadMaterials(){
        materials = []
        for index in 1...9{
            let material =  SCNMaterial()
            let name: String
            
            switch index {
            case 1:
                name = "mercury"
            case 2:
                name = "venus"
            case 3:
                name = "earth"
            case 4:
                name = "mars"
            case 5:
                name = "jupiter"
            case 6:
                name = "saturn"
            case 7:
                name = "uranus"
            case 8:
                name = "neptune"
            case 9:
                name = "pluto"
            default:
                name = "earth"
            }
            
            material.diffuse.contents = NSImage(imageLiteralResourceName: name)
            materials.append(material)
        }
    }
    
  
}
