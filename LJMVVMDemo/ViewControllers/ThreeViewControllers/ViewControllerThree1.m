//
//  ViewControllerThree1.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/9.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewControllerThree1.h"
#import "NSString+LJ.h"

#import "FriendModel.h"



@interface ViewControllerThree1 () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    NSMutableArray *_titles;
    
    //为了实现搜索
    UISearchBar *_searchBar;
    //为了保存搜索结果
    NSMutableArray *_searchArray;
    //为了显示搜素结果
    UISearchDisplayController *_sdc;
    
    
}


@end

@implementation ViewControllerThree1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UITabeView";
    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"--%@",[NSString firstCharactor:@"曹龙剑"]);
//    NSLog(@"++%@",[NSString firstCharactor:@"long"]);
    [self loadData];//
    [self createTableView];
    [self configNavigation];
    [self configSearch];
    
    
    
}
#pragma mark - 导航条
-(void)configNavigation
{
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(dealEdit:)];
    
    
    self.navigationItem.rightBarButtonItems = @[editItem];
}
#pragma mark - 搜索
-(void)configSearch
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
    _searchBar.placeholder = @"请求搜索";
    _tableView.tableHeaderView = _searchBar;
    
    
    _searchArray = [[NSMutableArray alloc] init];
    
    //创建显示搜索
    //参数1: 搜索条
    //参数2: 内容视图控制器, 设置为self
    //  搜索显示控制器内部还有tableView
    _sdc = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _sdc.searchResultsDataSource = self;
    
}
-(void)loadData
{
    _dataArray = [[NSMutableArray alloc] init];
    //生成数据
    //如果是分组显示数据, 一般数据源数组中每个又是数组, 每个数据包含了数据
    NSArray *names = @[@"小花",@"小草",@"小妹",@"小娘子",@"小王子",@"小小鸟"];
    for (int i='A'; i<='Z'; i++) {
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
        for (int j=0; j<10; j++) {
            //[subArray addObject:[NSString stringWithFormat:@"第%c组 第%d行数据",i,j]];
            FriendModel *model = [[FriendModel alloc] init];
            model.name = names[arc4random()%names.count];
            model.isDelete = NO;
            [subArray addObject:model];
        }
        [_dataArray addObject:subArray];
    }
    
    //创建包含A~Z数组
    _titles = [[NSMutableArray alloc] init];
    for (int i='A'; i<='Z'; i++) {
        [_titles addObject:[NSString stringWithFormat:@"%c",i]];
    }
}
#pragma mark - 创建表格视图
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //分割线
    _tableView.separatorColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)dealSearch
{
    [_searchArray removeAllObjects];
    
    for (NSMutableArray *subArray in _dataArray) {
        for (FriendModel *model in subArray) {
            if([model.name rangeOfString:_searchBar.text].location != NSNotFound)
            {
                [_searchArray addObject:model];
            }
        }
    }
}
-(void)dealEdit:(UIBarButtonItem *)item
{
    if(!_tableView.editing)
    {
        _tableView.editing = YES;
        item.title = @"完成";
    }
    else
    {
        _tableView.editing = NO;
        item.title = @"编辑";
        [self dealMultiSelectDelete];
    }
}
-(void)dealMultiSelectDelete
{
    //遍历每个子数组
    for (int i=0; i<_dataArray.count; i++) {
        NSMutableArray *subArray = _dataArray[i];
        for (int j=0; j<subArray.count; j++) {
            FriendModel *model = subArray[j];
            if(model.isDelete)
            {
                [subArray removeObjectAtIndex:j];
                j--;
            }
        }
    }
    
    [_tableView reloadData];
}

//返回段数/组数
//注意: 如果不实现,默认返回1
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //如果传入的tableView不是自己创建的tableView
    //  一定是搜索中的tableView
    if(tableView != _tableView)
    {
        [self dealSearch];
        return 1;
    }
    
    return _dataArray.count;
}
//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView != _tableView)//搜索结果的tableView
    {
        return _searchArray.count;
    }
    
    
    //根据传入段的序号section拿到子数组
    NSArray *subArray = _dataArray[section];
    return subArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    FriendModel *model = nil;
    if(tableView != _tableView)
    {
        model = _searchArray[indexPath.row];
    }
    else
    {
        model = _dataArray[indexPath.section][indexPath.row];
    }
    
    //cell默认控件
    cell.textLabel.text = model.name;
    
    NSString *head = indexPath.row%2?@"head1.jpg":@"head2.jpg";
    cell.imageView.image = [UIImage imageNamed:head];
    cell.detailTextLabel.text = @"我走了, 就这样轻轻的走了, 真的就只能这样了嘛?";
    
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //cell.accessoryView
    //注意: cell系统默认的控件frame改变了并没有什么*用...
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    
    
    return cell;
}

//代理方法, 给每个cell设置不同的高
//注意: cell默认高度44
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - 设置组头
//设置段的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView != _tableView)
    {
        return @"搜索结果";
    }
    return _titles[section];
}
//设置组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


#pragma mark - 移动
//代理方法, 支持移动
//参数1: 源位置
//参数2: 目标位置
//注意: 一旦添加这个方法,编辑状态下每个cell出现移动标志
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    //先从源数组拿出数据
    NSMutableArray *sourceArray = _dataArray[sourceIndexPath.section];
    id data = sourceArray[sourceIndexPath.row];
    
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    
    //插入目标数组
    NSMutableArray *destArray = _dataArray[destinationIndexPath.section];
    [destArray insertObject:data atIndex:destinationIndexPath.row];
    
}


#pragma mark - 删除和插入
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
}
//代理方法, cell向左滑动出现delete
//  点击delete执行代码
//参数1: 编辑风格 Delete,Insert
//参数2: 提供删除的行的位置
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row = %ld",indexPath.row);
    if(editingStyle == UITableViewCellEditingStyleDelete
       )
    {
        NSMutableArray *subArray = _dataArray[indexPath.section];
        [subArray removeObjectAtIndex:indexPath.row];
    }
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        //NSString *insertString = @"新数据";
        FriendModel *model = [[FriendModel alloc] init];
        model.name = @"新朋友";
        NSMutableArray *subArray = _dataArray[indexPath.section];
        [subArray insertObject:model atIndex:indexPath.row+1];
    }
    
    [tableView reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//设置删除按钮
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 选择和反选
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择 sec=%ld row=%ld",indexPath.section,indexPath.row);
    if(tableView.editing)
    {
        FriendModel *model = _dataArray[indexPath.section][indexPath.row];
        model.isDelete = YES;
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"反选 sec=%ld row=%ld",indexPath.section,indexPath.row);
    FriendModel *model = _dataArray[indexPath.section][indexPath.row];
    model.isDelete = NO;
}

#pragma mark - 索引
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _titles;
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
