//
//  NXWebViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/6.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXWebViewController.h"
#import <WebKit/WebKit.h>
@interface NXWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic ,strong)WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@end

@implementation NXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView * webView = [[WKWebView alloc]init];
    _webView = webView;
    [self.containerView addSubview:webView];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    
    
    [self addObserver:self forKeyPath:@"estimatedProgress" options: NSKeyValueObservingOptionNew context:nil];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _webView.frame = self.containerView.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NXLog(@"change:%@",change);
     self.progress.progress = self.webView.estimatedProgress;
}
- (IBAction)backClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)forwardClick:(id)sender {
    [self.webView goForward];
}
- (IBAction)refreshClick:(id)sender {
    [self.webView reload];
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
