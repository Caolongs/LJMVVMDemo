//
//  ContactsViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/11/15.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ContactsViewController.h"
#import <ContactsUI/ContactsUI.h>//提供了界面
#import <Contacts/Contacts.h> //需要自己搭建页面

#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@interface ContactsViewController () <CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通讯录";
    [self configViews];
    [self configDatas];
}

- (void)configViews{
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(show:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)configDatas{
    
}

- (void)show:(id)sender {
//    if (IS_iOS9) {
//        [self showContactUI];//Contact有UI
//    }else{
        [self showAddressBookUI];
//    }
    
}
- (void)showCustomUI:(id)sender {
    [self contactCustomView];//Contact无UI
    [self addressCustomView];//Add无AddressBook无UI
}




#pragma mark - <ContactsUI/ContactsUI.h>
- (void)showContactUI{
    // 1.创建选择联系人的控制器
    CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc] init];
    
    // 2.设置代理
    contactVc.delegate = self;
    
    // 3.弹出控制器
    [self presentViewController:contactVc animated:YES completion:nil];
}

#pragma mark - <CNContactPickerDelegate>
// 当选中某一个联系人时会执行该方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName;
    NSString *firstname = contact.givenName;
    NSLog(@"%@ %@", lastname, firstname);
    
    // 2.获取联系人的电话号码
    NSArray *phoneNums = contact.phoneNumbers;
    for (CNLabeledValue *labeledValue in phoneNums) {
        // 2.1.获取电话号码的KEY
        NSString *phoneLabel = labeledValue.label;
        
        // 2.2.获取电话号码
        CNPhoneNumber *phoneNumer = labeledValue.value;
        NSString *phoneValue = phoneNumer.stringValue;
        
        NSLog(@"%@ %@", phoneLabel, phoneValue);
    }
}

// 当选中某一个联系人的某一个属性时会执行该方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    
}


//#pragma mark - 选中多个联系人
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
//
//    NSLog(@"contactscontacts:%@",contacts);
//}

//#pragma mark - 选中一个联系人的多个属性
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
//    
//    NSLog(@"contactPropertiescontactProperties:%@",contactProperties);
//}


// 点击了取消按钮会执行该方法
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    
}


#pragma mark -  showAddressBookUI
- (void)showAddressBookUI{
    ABPeoplePickerNavigationController * peoplePickerNav = [ABPeoplePickerNavigationController new];
    
    peoplePickerNav.peoplePickerDelegate = self;
    //下面的判断是ios8之后才需要加的，不然会自动返回app内部
    if(IS_iOS8){
        //predicateForSelectionOfPerson默认是true （当你点击某个联系人查看详情的时候会返回app），如果你默认为true 但是实现-peoplePickerNavigationController:didSelectPerson:property:identifier:代理方法也是可以的，与此同时不能实现peoplePickerNavigationController: didSelectPerson:不然还是会返回app。
        //总之在ios8之后加上此句比较稳妥
        peoplePickerNav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        //predicateForSelectionOfProperty默认是true （当你点击某个联系人的某个属性的时候会返回app），此方法只要是默认值，无论你代理方法实现与否都会返回app。
        //        _abPeoplePickerVc.predicateForSelectionOfProperty = [NSPredicate predicateWithValue:false];
        //predicateForEnablingPerson默认是true，当设置为false时，所有的联系人都不能被点击。
        //        _abPeoplePickerVc.predicateForEnablingPerson = [NSPredicate predicateWithValue:true];
     }
    
    [self presentViewController:peoplePickerNav animated:YES completion:nil];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate

//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
//
//    NSLog(@"选中了person,%@",person);
//}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    NSLog(@"选中了属性,property:%d,identifier:%d",property,identifier);
    
}









#pragma mark - Contact - 无UI
- (void)contactCustomView
{
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    // 2.判断授权状态,如果不是已经授权,则直接返回
    if (status != CNAuthorizationStatusAuthorized) return;
    //    CNContactStore *store = [[CNContactStore alloc] init];
    //    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
    //        if (granted) {NSLog(@"授权成功");}
    //    }];
    
    // 3.创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 5.遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSLog(@"hh-%@ mm-%@", lastname, firstname);
        
        // 2.获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        for (CNLabeledValue *labeledValue in phoneNums) {
            // 2.1.获取电话号码的KEY
            NSString *phoneLabel = labeledValue.label;
            
            // 2.2.获取电话号码
            CNPhoneNumber *phoneNumer = labeledValue.value;
            NSString *phoneValue = phoneNumer.stringValue;
            
            NSLog(@"---%@ ===%@", phoneLabel, phoneValue);
        }
    }];
}


#pragma mark - AddressBook-无UI
- (void)addressCustomView{
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip = 0;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook = nil;
    
    //创建通讯簿的引用
    addBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //创建一个出事信号量为0的信号
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //申请访问权限
    ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
        //greanted为YES是表示用户允许，否则为不允许
        if (!greanted) {
            tip = 1;
        }
        //发送一次信号
        dispatch_semaphore_signal(sema);
    });
    //等待信号触发
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (tip) {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    //进行遍历
    for (int i = 0; i < number; i++) {
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        
        //获取当前联系人名字
        NSString * firstName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        //获取当前联系人姓氏
        NSString * lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        //获取当前联系人的名字拼音
        NSString * firstNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonFirstNamePhoneticProperty));
        
        //获取当前联系人的备注
        NSString * notes = (__bridge NSString*)(ABRecordCopyValue(people, kABPersonNoteProperty));
        
        //获取当前联系人的电话 数组
        NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j = 0; j < ABMultiValueGetCount(phones); j++) {
            [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
        }
        
        //获取当前联系人头像图片
        NSData * userImage=(__bridge NSData*)(ABPersonCopyImageData(people));
        
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
