//
//  PrintimageAviationLabelViewController.m
//  tms-ios
//
//  Created by wangww on 2020/12/30.
//  Copyright © 2020 wangziting. All rights reserved.
//

#import "PrintimageAviationLabelViewController.h"
#import "Tools.h"

@interface PrintimageAviationLabelViewController ()

// 二维码
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
// 始发站，中文 // 为了达到整体居中效果，两个字段拼接在一起
@property (weak, nonatomic) IBOutlet UILabel *startCity;
// 到达站，中文
@property (weak, nonatomic) IBOutlet UILabel *endCity;
// 到达站，编码
@property (weak, nonatomic) IBOutlet UILabel *flightArrcode;
// 始发站，编码
@property (weak, nonatomic) IBOutlet UILabel *flightDepcode;
// 始发站中文 / 始发站编码
@property (weak, nonatomic) IBOutlet UILabel *startCity_flightDepcode;
// 到达站中文 / 到达站编码
@property (weak, nonatomic) IBOutlet UILabel *endCity_flightArrcode;
// 航班号
@property (weak, nonatomic) IBOutlet UILabel *actualFlightNo;
// 航班日期
@property (weak, nonatomic) IBOutlet UILabel *airlineDate;
// 运单号
@property (weak, nonatomic) IBOutlet UILabel *productNo;
// 运单号条形码
@property (weak, nonatomic) IBOutlet UIImageView *barCodeImageView;

@end

@implementation PrintimageAviationLabelViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _qrCodeImageView.image = [Tools createQRWithString:_dic[@"newQRCode"] QRSize:_qrCodeImageView.frame.size];
    
//    _startCity.text = _dic[@"startCity"];
//    _endCity.text = _dic[@"endCity"];
//    _flightArrcode.text = _dic[@"flightArrcode"];
//    _flightDepcode.text = _dic[@"flightDepcode"];
    _startCity_flightDepcode.text = [NSString stringWithFormat:@"%@ /%@", _dic[@"flightDepcode"], _dic[@"startCity"]];
    _endCity_flightArrcode.text = [NSString stringWithFormat:@"%@ /%@", _dic[@"flightArrcode"], _dic[@"endCity"]];
    _actualFlightNo.text = _dic[@"actualFlightNo"];
    _airlineDate.text = _dic[@"airlineDate"];
    
    _productNo.text = _productNo_s;
    _barCodeImageView.image = [Tools resizeCodeWithString:_productNo_s BCSize:_barCodeImageView.frame.size];
}
@end
