# PXNetWorkingManaer
### get方法
```objc
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(1);
    
    // 发送请求
    [PXNetWorkingManager getWithUrl:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
       
        self.textView.text = [NSString stringWithFormat:@"%@",responseObject];
        NSLog(@"%@",responseObject);
    } faliure:^(NSError *error) {
        
    }]
```

