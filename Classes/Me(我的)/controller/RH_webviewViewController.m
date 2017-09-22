//
//  RH_webviewViewController.m
//  
//
//  Created by 阮浩 on 17/9/7.
//
//

#import "RH_webviewViewController.h"

@interface RH_webviewViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;

@end

@implementation RH_webviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview.delegate = self;
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 监听按钮点击

- (IBAction)backButton:(id)sender {
    [self.webview goBack];
}
- (IBAction)forward:(id)sender {
    [self.webview goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webview reload];
}

#pragma mark - UIWebViewDelegate代码实现
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.back.enabled = webView.canGoBack;
    self.forward.enabled = webView.canGoForward;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
