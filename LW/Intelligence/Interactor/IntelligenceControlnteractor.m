//
//  IntelligenceControlnteractor.m
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "IntelligenceControlnteractor.h"
#import "BabyBluetooth.h"
#import "LWCellBaseModel.h"
#import "LWTableSectionBaseModel.h"
#import "LWCBPeripheralModel.h"

@implementation IntelligenceControlnteractor
- (void)scanBlueth:(void(^)())successed{
    [self getBluetoothList];
//    //初始化BabyBluetooth 蓝牙库
//    //设置蓝牙委托
    [self babyDelegate:^(NSString *bluetoothName) {
        successed?successed():nil;
    }];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态
    [BabyBluetooth shareBabyBluetooth].scanForPeripherals().connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

-(void)babyDelegate:(void(^)(NSString *bluetoothName))successed{
    
    __weak __typeof (&*self)weakSelf = self;

    //设置扫描到设备的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        if (peripheral.name) {
        }
    }];
    
    //设置查找设备的过滤器
    [[BabyBluetooth shareBabyBluetooth] setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        if (peripheralName.length >1) {
            
            successed?successed(peripheralName):nil;
            [weakSelf getBluetoothListWithBluetoothName:peripheralName];
            return YES;
        }
        return NO;
    }];
    
    //连接过滤器
    __block BOOL isFirst = YES;
    [[BabyBluetooth shareBabyBluetooth] setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
//        //这里的规则是：连接第一个设备
//        isFirst = NO;
//        return YES;
        //这里的规则是：连接第一个P打头的设备
                if(isFirst && [peripheralName hasPrefix:@"MiniBeacon_00174"]){
                    isFirst = NO;
                    return YES;
                }
                return NO;
    }];
    
    //设置设备连接成功的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        //设置连接成功的block
        NSLog(@"设备：%@--连接成功",peripheral.name);
        //停止扫描
        [[BabyBluetooth shareBabyBluetooth] cancelScan];
    }];
    
    //连接Peripherals失败的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        //设置连接失败的block
        NSLog(@"设备：%@--连接失败",peripheral.name);
        //停止扫描
        [[BabyBluetooth shareBabyBluetooth] cancelScan];
    }];
    
    //断开Peripherals的连接
    [[BabyBluetooth shareBabyBluetooth] setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        //设置连接失败的block
        NSLog(@"设备：%@--断开链接",peripheral.name);
        //停止扫描
    }];
    
    //设置发现设备的Services的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *service in peripheral.services) {
            NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
        }
    }];
    //设置发现设service的Characteristics的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
    }];
    
    
    
    //设置读取characteristics的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [[BabyBluetooth shareBabyBluetooth] setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
}

-(void)getBluetoothList{
    [self.dataArrayM removeAllObjects];
    NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:0];
    LWTableSectionBaseModel *topicSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:nil];
    [self.dataArrayM addObject:topicSectionModel];
}

-(void)getBluetoothListWithBluetoothName:(NSString *)name{
    LWTableSectionBaseModel *topicSectionModel = [self.dataArrayM firstObject];
    LWCellBaseModel *cellModel =  [LWCellBaseModel alloc];
    cellModel.cellName = @"SwitchCell";
    cellModel.title = name;
    [topicSectionModel.rowArrayM addObject:cellModel];
}

-(NSMutableArray *)dataArrayM{
    _dataArrayM = _dataArrayM?:[NSMutableArray arrayWithCapacity:0];
    return _dataArrayM;
}
@end
