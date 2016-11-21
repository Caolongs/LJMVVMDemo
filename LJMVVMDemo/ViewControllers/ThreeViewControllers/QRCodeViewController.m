//
//  QRCodeViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/11/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) AVCaptureSession * session;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer * layer;
@property(nonatomic, strong) UIView *boxView;
@property(nonatomic, strong) UILabel *lblStatus;
@property(nonatomic, strong) CALayer *scanLayer;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startReading];
    
}

- (BOOL)startReading{
    // 1.创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2.添加输入设备(数据从摄像头输入)
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到XXX打开相机访问权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        return NO;
    }
    if (error) {
        NSLog(@"error - %@",[error localizedDescription]);
        return NO;
    }
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    // 3.添加输出数据(示例对象-->类对象-->元类对象-->根元类对象)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,
                                     AVMetadataObjectTypeEAN13Code,
                                     AVMetadataObjectTypeEAN8Code,
                                     AVMetadataObjectTypeCode128Code]];
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    //设置扫描范围
    output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.6f, 0.6f);
    
    //设置扫描框/扫描线
    [self cofigScanView];
    
    if ([UIScreen mainScreen].bounds.size.width == 320){
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }else{
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    // 5.开始扫描
    [session startRunning];
    return YES;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 当扫描到数据时就会执行该方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        //获得扫描数据，最后一个时最新扫描的数据
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@", object.stringValue);
        
        // 停止扫描
        [self stopReading];
        
    } else {
        NSLog(@"没有扫描到数据");
    }
}

- (void)cofigScanView{
    //扫描框
    CGFloat sWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat sHeight = [UIScreen mainScreen].bounds.size.height;
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(sWidth * 0.2f, sHeight * 0.2f, sWidth - sWidth * 0.4f, sHeight - sHeight * 0.4f)];
    _boxView.layer.borderColor = [UIColor orangeColor].CGColor;
    _boxView.layer.borderWidth = 2.0f;
    [self.view addSubview:_boxView];
    //扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor redColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)moveScanLayer:(NSTimer *)timer{
    static CGFloat hl = 0.1;
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y +50*hl) {
        _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    }else{
        frame.origin.y += 20*hl;
        [UIView animateWithDuration:0.01f animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

//停止扫描
-(void)stopReading{
    [self.session stopRunning];
    self.session = nil;
    [self.scanLayer removeFromSuperlayer];
    [self.layer removeFromSuperlayer];
    [self.boxView removeFromSuperview];
}

- (void)presentAlertView:(NSString *)title{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
