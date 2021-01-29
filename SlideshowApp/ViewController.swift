//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 中川Air利光 on 2021/01/27.
//

import UIKit

class ViewController: UIViewController {

    // 画像表示領域
    @IBOutlet weak var selectImg: UIImageView!
    
    var imgno:Int = 0               // 表示画像番号
    let imgtbl = ["ofkph1466.jpg", "ofkph1750.jpg", "ofkph2328.jpg", "ofkph2351.jpg", "ofkph2360.jpg"]  // 画像名配列

    var timer: Timer!               // タイマー
    var timer_sec: Float = 0        // タイマー間隔（秒）
    var autoplay_flg = 0            // 自動再生フラグ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        img_display()               // 現在の画像番号に対応した画像を表示
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if autoplay_flg == 1 {          // 自動再生中？
            timer.invalidate()          // タイマー停止
            self.timer = nil
        }
        let imgViewController:ImgViewController = segue.destination as! ImgViewController
        imgViewController.imgname = imgtbl[imgno]
    }

    // ====================================================================================
    // タイマーによる自動画像変更処理
    // ====================================================================================
    @objc func imgchangeTimer(_ timer: Timer){
        if imgno < 4 {              // 進める範囲？
            imgno += 1              // 画像位置番号を一つ先に設定
        }
        else {                      // これ以上進めない？
            imgno = 0               // 画像位置番号を先頭に強制設定
        }
        img_display()               // 現在の画像番号に対応した画像を表示
    }
    
    // ====================================================================================
    // 進むボタン処理
    // ====================================================================================
    @IBOutlet weak var Next: UIButton!
    @IBAction func next(_ sender: Any) {
        if imgno < 4 {              // 進める範囲？
            imgno += 1              // 画像位置番号を一つ先に設定
        }
        else {                      // これ以上進めない？
            imgno = 0               // 画像位置番号を先頭に強制設定
        }
        img_display()               // 現在の画像番号に対応した画像を表示
    }
    //-------------------------------------------------------------------------------------

    // ====================================================================================
    // 戻るボタン処理
    // ====================================================================================
    @IBOutlet weak var Prev: UIButton!
    @IBAction func prev(_ sender: Any) {
        if imgno > 0 {              // 戻れる範囲？
            imgno -= 1              // 画像位置番号を一つ前に設定
        }
        else {                      // これ以上戻れない？
            imgno = 4               // 画像位置番号を最終に強制設定
        }
        img_display()               // 現在の画像番号に対応した画像を表示
    }
    //-------------------------------------------------------------------------------------

    // ====================================================================================
    // 再生・停止ボタン処理
    // ====================================================================================
    @IBOutlet weak var Start_stop: UIButton!
    @IBAction func start_stop(_ sender: Any) {
        if autoplay_flg == 0 {      // 自動再生していない？
            autoplay_flg = 1        // 自動再生フラグをONに設定
            Next.isEnabled = false  // 進むボタンを無効にする
            Prev.isEnabled = false  // 戻るボタンを無効にする
            Start_stop.setTitle("停止", for: .normal) // 再生・停止ボタンの表示を「停止」に変更
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(imgchangeTimer(_:)), userInfo: nil, repeats: true)
            }
        }
        else {                      // 自動再生中？
            autoplay_flg = 0        // 自動再生フラグをOFFに設定
            Next.isEnabled = true   // 進むボタンを有効にする
            Prev.isEnabled = true   // 戻るボタンを有効にする
            Start_stop.setTitle("再生", for: .normal) // 再生・停止ボタンの表示を「再生」に変更
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
        }
//      dbdisp.text = "imgno = \(imgno)"  // デバッグ情報表示
    }
    //-------------------------------------------------------------------------------------

    // ====================================================================================
    // 前の画面から戻ってきた時の処理
    // ====================================================================================
    @IBAction func unwind(_ segue: UIStoryboardSegue){
        if autoplay_flg == 1 {      // 自動再生中だった？
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(imgchangeTimer(_:)), userInfo: nil, repeats: true)
        }
        //
    }
    //-------------------------------------------------------------------------------------

    // ====================================================================================
    // ■ 関数
    //      img_display( )
    // ■ 機能
    //      現在設定されている、画像番号の画像を表示する。
    // ====================================================================================
    func img_display(){
        let name = imgtbl[imgno]
        let image = UIImage(named: name)
        selectImg.image = image
        //dbdisp.text = "\(imgno) / \(name)" // デバッグ情報表示
    }
    //-------------------------------------------------------------------------------------

}

