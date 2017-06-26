//
//  ViewController.swift
//  MyApp09
//
//  Created by user on 2017/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    private var a = 0
    
    @IBAction func btn1(_ sender: Any) {
        // queue 裡同步（sync）跟非同步(async)
        //main  沒有sync他是在main中做的所以會使其他的async停下
        //已經是作業系統的層級 so task要加self,用main就做完再做下一個
//        DispatchQueue.main.async {
//            self.task1()
//        }
        //global 加入優先權所以可以做到多工(這是分時多工)
        DispatchQueue.global().async {
            self.task1()
        }
//        DispatchQueue.global().sync {
//            self.task2()
//        }
//        DispatchQueue.global().async {
//            self.task3()
//        }
//-----------------------------------------------------------
//    結論：跟ui有關的用main,跟ui沒關的用global()
//-----------------------------------------------------------
    }
    
    @IBAction func btn2(_ sender: Any) {
//        DispatchQueue.main.async {
//            self.task2()
//        }
        DispatchQueue.global().async {
            self.task2()
        }
    }
    
    
    func task1(){
        for i in 1...10{
            print("A\(i)")
            usleep(200*1000)
            DispatchQueue.main.async {
                print("in:\(i)")
                self.lb1.text = String(i)
            }
        }
    }
    
    func task2(){
        for i in 1...10{
            print("B\(i)")
            usleep(600*1000)
            DispatchQueue.main.async {
                print("in:\(i)")
                self.lb2.text = String(i)
            }
        }
    }
    
    func task3(){
        for i in 1...10{
            print("c\(i)")
            usleep(1)
            
        }
    }
    
//用物件的方式是寫
    @IBAction func btn3(_ sender: Any) {
        let opq = OperationQueue()
        opq.addOperation {
            for i in 1...10{
                sleep(1)
                DispatchQueue.main.async {
                    self.lb1.text = String(i)
                }
            }
        }
        opq.addOperation {
            for i in 1...10{
                sleep(2)
                DispatchQueue.main.async {
                    self.lb2.text = String(i)
                }
            }
        }
    }
    
    
    
    @IBAction func btn4(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in
            self.task4()
        
        })
    }
    func task4(){
        a += 1
        lb1.text = String(a)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

