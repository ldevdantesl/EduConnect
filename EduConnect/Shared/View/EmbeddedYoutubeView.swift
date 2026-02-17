//
//  EmbeddedYoutubeView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 30.01.2026.
//

import UIKit
import WebKit
import SnapKit

final class EmbeddedYouTubeView: UIView {
    
    private var webView: WKWebView!
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWebView()
    }
    
    deinit {
        stopAndCleanup()
    }
    
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        config.defaultWebpagePreferences = prefs
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .black
        webView.isOpaque = false
        webView.isUserInteractionEnabled = false
        webView.navigationDelegate = self
        
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        
        addSubview(webView)

        webView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(3.0)
            $0.height.equalToSuperview().multipliedBy(3.0)
        }
        
        webView.addSubview(dimmingView)
        dimmingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        clipsToBounds = true
        backgroundColor = .black
    }
    
    func loadVideo(url: String) {
        guard let videoID = url.extractYouTubeID() else { return }
        loadVideo(videoID: videoID)
    }
    
    func loadVideo(videoID: String) {
        let urlString = "https://www.youtube-nocookie.com/embed/\(videoID)?enablejsapi=1&disablekb=1&controls=0&rel=0&iv_load_policy=3&cc_load_policy=0&playsinline=1&showinfo=0&modestbranding=1&fs=0&mute=1&loop=1&playlist=\(videoID)&autoplay=1"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("https://educonnect.kz/", forHTTPHeaderField: "Referer")
        
        webView.load(request)
    }
    
    func stopAndCleanup() {
        webView?.stopLoading()
        webView?.loadHTMLString("", baseURL: nil)
        webView?.navigationDelegate = nil
    }
}

// MARK: - WKNavigationDelegate
extension EmbeddedYouTubeView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
