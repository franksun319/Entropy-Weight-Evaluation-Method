# Entropy_Weight_Method

## 功能
为评价指标计算熵权，生成权重列，供后续合成计算

## 使用方法
1. 运行该*脚本*：
```
do "计算熵权.do"
```

2. 调用函数*entropy_weight*：
```
entropy_weight var_list [if] [in] , dir(["a"|"b"])
```

## 输入
- stata数据集中的变量列表。
- 选项："a"表示输入变量都是正向指标，"d"逆向指标。

## 输出
生成对应于各个变量的熵权列，名称以"ew_"开头。
