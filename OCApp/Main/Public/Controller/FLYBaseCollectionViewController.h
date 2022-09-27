//
//  FLYBaseCollectionViewController.h
//  ProvideAged
//
//  Created by fly on 2021/12/24.
//

//此类暂时不适合继承，复制出去改改用吧 (因为CollectionView的Layout外界没传进来，样式是写死的。)

#import "FLYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYBaseCollectionViewController : FLYBaseViewController < UICollectionViewDataSource, UICollectionViewDelegate >

@property (nonatomic, strong) UICollectionView * collectionView;

@end

NS_ASSUME_NONNULL_END
