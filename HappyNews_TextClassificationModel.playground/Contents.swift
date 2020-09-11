import CreateML
import Cocoa

//感情分類ファイルの呼び出し(準備)
guard let trainingDataFileURL = Bundle.main.url(forResource: "sentiment_analysis_training", withExtension: "json"),
      let testingDataFileURL  = Bundle.main.url(forResource: "sentiment_analysis_test", withExtension: "json") else {
    fatalError("Error! Couldn't load resource files")
}

//トレーニングとテスト用データの準備
do {
    let trainingDataTable = try MLDataTable(contentsOf: trainingDataFileURL)
    let testingDataTable  = try MLDataTable(contentsOf: testingDataFileURL)
    
    let stats = """
    ===================================================
    Entries used of training: \(trainingDataTable.size)
    Entries used of testing : \(testingDataTable.size)
"""
    print(stats)
    
    //テキスト分類の作成とトレーニング
    let sentimentClassifier = try MLTextClassifier(trainingData: trainingDataTable, textColumn: "text", labelColumn: "label")
    
    //分類器の精度と評価
    let evaluationMetrics = sentimentClassifier.evaluation(on: testingDataTable, textColumn: "text", labelColumn: "label")
    
    let trainingAccuracy   = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
    let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
    let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

    
    let message = """
    ==========================================================
    Training   accuracy(トレーニング精度)　: \(trainingAccuracy)
    Varidation accuracy(バリデーション精度): \(validationAccuracy)
    Evaluation accuracy(評価精度)　　　　　: \(evaluationAccuracy)
"""
    
    print(message)
    
    //CoreMLモデルとして保存するpathを変数化
    let modelFileURL = URL(fileURLWithPath: "/Users/sasakiken/ios_projects/HappyNews_TextClassificationModel/HappyNews_TextClassification.mlmodel")
    
    
    
} catch {
    print(error.localizedDescription)
}
