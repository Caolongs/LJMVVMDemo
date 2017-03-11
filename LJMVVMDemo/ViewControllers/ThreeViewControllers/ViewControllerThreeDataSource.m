//
//  ViewControllerThreeDataSource.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/10.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "ViewControllerThreeDataSource.h"
#import "LJCellObject.h"

@interface ViewControllerThreeDataSource ()

@property (nonatomic, strong) NSMutableArray<LJCellObject *> *itemArray;

@end

@implementation ViewControllerThreeDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemArray = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray<LJCellObject *> *)getItems{
    
    NSArray *dataArray = @[@"UITableView-searcSh",@"UISerachViewController",@"ContactsDemo",@"二维码",@"4.safe-dictionary-array",@"pdf预览"];
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LJCellObject *cellObject1 = [[LJCellObject alloc] init];
        cellObject1.cellClass = [UITableViewCell class];
        
        cellObject1.title = dataArray[idx];
        [self.itemArray addObject:cellObject1];
    }];
    
    
    return _itemArray;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    LJCellObject *cellObj = self.itemArray[indexPath.row];
    
    [tableView registerClass:cellObj.cellClass forCellReuseIdentifier:NSStringFromClass(cellObj.class)];
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellObj.class)];
    cell.textLabel.text = cellObj.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lj_tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate lj_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
//    if (indexPath.row == 0) {
    
//        //ViewControllerThree1 *oneVC = [[ViewControllerThree1 alloc] init];
//        ViewControllerThree1 *oneVC = [[ViewControllerThree1 alloc] initWithNibName:@"ViewControllerThree1" bundle:nil];
//        [self.navigationController pushViewController:oneVC animated:YES];
//    }else if (indexPath.row == 1){
//        LJUISearchBarVC *searchVC = [[LJUISearchBarVC alloc] init];
//        [self.navigationController pushViewController:searchVC animated:YES];
//    }else if (indexPath.row == 2){
//        ContactsViewController *contactVC = [[ContactsViewController alloc] init];
//        [self.navigationController pushViewController:contactVC animated:YES];
//        
//    }else if (indexPath.row == 3){
//        QRCodeViewController *vc = [[QRCodeViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }else if (indexPath.row == 4){
//        SafeTestViewController *vc = [[SafeTestViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }else if (indexPath.row == 5){
//        PDFViewController *vc = [[PDFViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }else{
//        WebViewWK_VC *searchVC = [[WebViewWK_VC alloc] init];
//        [self.navigationController pushViewController:searchVC animated:YES];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
