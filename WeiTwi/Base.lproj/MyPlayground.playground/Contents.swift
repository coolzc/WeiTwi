//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let sineArraySize = 64

let frequency1 = 4.0
let phase1 = 0.0
let amplitude1 = 2.0
let sineWave = (0..<sineArraySize).map {
    amplitude1 * sin(2.0 * M_PI / Double(sineArraySize) * Double($0) * frequency1 + phase1)
}

func plotArrayInPlayground<T>(arrayToPlot:Array<T>, title:String) {
    for _ in arrayToPlot {
    }
}

plotArrayInPlayground(sineWave, title: "Sine wave 1")
