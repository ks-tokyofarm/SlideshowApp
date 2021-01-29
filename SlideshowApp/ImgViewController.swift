//
//  ImgViewController.swift
//  SlideshowApp
//
//  Created by 中川Air利光 on 2021/01/27.
//

import UIKit

class ImgViewController: UIViewController {
    
    //拡大画像用イメージビュー
    @IBOutlet weak var bigimage: UIImageView!
    
    // 受け取る為のプロパティ
    var imgname:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // 画像の表示
        let image = UIImage(named: imgname) // 指定画像ファイル情報を取得
        bigimage.image = image              // 画像のイメージを設定（表示）

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
