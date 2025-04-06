# Entropy Weight Evaluation Method

## Function
The entropy weight is calculated for the evaluation index, and the weight column is generated for subsequent synthetic calculation.

为评价指标计算熵权，生成权重列，供后续合成计算。

## Usage
1. Run the *script*:
运行该*脚本*：
```
do "计算熵权.do"
```
2. Call function *entropy_weight*:
调用函数*entropy_weight*：
```
entropy_weight var_list [if] [in] , type(+|-)
```

## Input
- List of variables in the stata dataset.

stata数据集中的变量列表。

- Option: "+" indicates that the input variables are all positive indicators, "-" contrarian indicators.

选项："+"表示输入变量都是正向指标，"-"逆向指标。
 
## Output
Generates an entropy weight column corresponding to each variable, with names starting with "*ew_*".

生成对应于各个变量的熵权列，名称以"*ew_*"开头。
