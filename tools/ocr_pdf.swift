import Foundation
import PDFKit
import Vision
import CoreGraphics

let args = CommandLine.arguments
guard args.count >= 2 else {
    fputs("Usage: ocr_pdf.swift <pdf-path> [page-limit]\n", stderr)
    exit(1)
}

let pdfPath = args[1]
let pageLimit = args.count >= 3 ? Int(args[2]) : nil
let url = URL(fileURLWithPath: pdfPath)

guard let document = PDFDocument(url: url) else {
    fputs("Could not open PDF at \(pdfPath)\n", stderr)
    exit(1)
}

let maxPages = min(document.pageCount, pageLimit ?? document.pageCount)

func renderPage(_ page: PDFPage, scale: CGFloat = 2.0) -> CGImage? {
    guard let pageRef = page.pageRef else { return nil }
    let rect = page.bounds(for: .mediaBox)
    let width = max(Int(rect.width * scale), 1)
    let height = max(Int(rect.height * scale), 1)
    let colorSpace = CGColorSpaceCreateDeviceRGB()

    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
    ) else {
        return nil
    }

    context.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 1))
    context.fill(CGRect(x: 0, y: 0, width: width, height: height))
    context.saveGState()
    context.translateBy(x: 0, y: CGFloat(height))
    context.scaleBy(x: scale, y: -scale)
    context.drawPDFPage(pageRef)
    context.restoreGState()
    return context.makeImage()
}

for pageIndex in 0..<maxPages {
    autoreleasepool {
        guard let page = document.page(at: pageIndex) else { return }
        guard let image = renderPage(page) else {
            fputs("Could not render page \(pageIndex + 1)\n", stderr)
            return
        }

        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["de-DE", "en-US"]

        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            try handler.perform([request])
            let lines = (request.results ?? []).compactMap { observation in
                observation.topCandidates(1).first?.string
            }
            print("===== PAGE \(pageIndex + 1) =====")
            print(lines.joined(separator: "\n"))
        } catch {
            fputs("OCR failed on page \(pageIndex + 1): \(error)\n", stderr)
        }
    }
}
