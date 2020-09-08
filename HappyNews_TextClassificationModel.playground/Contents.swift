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
    
} catch {
    print(error.localizedDescription)
}
