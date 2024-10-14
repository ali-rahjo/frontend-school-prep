import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
        print("Loading: \(url.absoluteString)")
    }
}

struct Admin: View {
    var body: some View {
        WebView(url: URL(string: "http://192.168.0.219:8000/admin/login/?next=/admin/")!)

            .edgesIgnoringSafeArea(.all) 
    }
}

struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}

