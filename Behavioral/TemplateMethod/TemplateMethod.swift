//
//  Template method
//

import Foundation

protocol DataMiner {
    func readData(from url: URL) -> Data?
    func parse(_ data: Data) -> String?
    func analizy(_ string: String) -> String?
    func send(_ report: String)
    func templateMethod(path: String)
}

extension DataMiner {
    func analizy(_ string: String) -> String? {
        let report = "Analysis of the received data."
        print(report)
        return report
    }
    
    func send(_ report: String) {
        print("Sending: \(report)")
    }
    
    func templateMethod(path: String) {
        guard let url = URL(string: path) else  {
            return
        }
        
        guard let data = readData(from: url) else {
            return
        }
        
        guard let string = parse(data) else {
            return
        }
        
        guard let report = analizy(string) else {
            return
        }
        
        send(report)
    }
}

class PdfDataMiner: DataMiner {
    func readData(from url: URL) -> Data? {
        print("Reading data from PDF file: \(url).")
        let data = Data()
        return data
    }
    
    func parse(_ data: Data) -> String? {
        print("Parsing data from this PDF.")
        let string = String()
        return string
    }
}

class DocDataMiner: DataMiner {
    func readData(from url: URL) -> Data? {
        print("Reading data from DOC file: \(url).")
        let data = Data()
        return data
    }
    
    func parse(_ data: Data) -> String? {
        print("Parsing data from this DOC.")
        let string = String()
        return string
    }
}

// Client

class Client {
    func run() {
        let pdfDataMiner = PdfDataMiner()
        pdfDataMiner.templateMethod(path: "https://website.com/file.pdf")
    }
}

// Client().run()

// Reading data from PDF file: https://website.com/file.pdf.
// Parsing data from this PDF.
// Analysis of the received data.
// Sending: Analysis of the received data.
