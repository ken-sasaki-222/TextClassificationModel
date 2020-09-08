import CreateML
import Cocoa

//テキスト分類データの準備
guard let trainingDataFileURL = Bundle.main.url(forResource: "sentiment_analysis_training", withExtension: "json"),
      let testingDataFileURL  = Bundle.main.url(forResource: "sentiment_analysis_test", withExtension: "json") else {
    fatalError("Error! Couldn't load resource files")
}
