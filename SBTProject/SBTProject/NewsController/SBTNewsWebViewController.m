//
//  SBTNewsWebViewController.m
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTNewsWebViewController.h"
#import <Masonry.h>

@interface SBTNewsWebViewController () <UIWebViewDelegate>


@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;


@end

@implementation SBTNewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
    self.webView = [UIWebView new];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlNewsString]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicatorView.color = UIColor.redColor;
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.webView addSubview: self.activityIndicatorView];
    [self setConstraints];
}

- (void)setConstraints
{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.webView.mas_top);
        make.left.mas_equalTo(self.webView.mas_left);
        make.bottom.mas_equalTo(self.webView.mas_bottom);
        make.right.mas_equalTo(self.webView.mas_right);
    }];
}

#pragma mark - Webv view delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"webViewDidStartLoad");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    [self.activityIndicatorView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [self.activityIndicatorView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicatorView stopAnimating];
}


@end
