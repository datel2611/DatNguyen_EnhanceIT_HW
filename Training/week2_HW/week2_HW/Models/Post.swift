//
//  Post.swift
//  week2_HW
//
//  Created by Consultant on 09/01/1401 AP.
//

import Foundation

struct Post: Decodable {
    let photos: [Photos]
}

struct Photos: Decodable {
    let id: Int
    let sol: Int
    let camera: Camera
    let img_src: String
    let earth_date: String
    let rover: Rover
}

struct Rover: Decodable{
    let id: Int
    let name: String
    let landing_date: String
    let launch_date: String
    let status: String
}

struct Camera: Decodable{
    let id: Int
    let name: String
    let rover_id: Int
    let full_name: String
}

