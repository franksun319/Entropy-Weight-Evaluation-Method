# Entropy Weight Evaluation Method

## Function
Calculate entropy weights for evaluation indicators, generate weight columns, and calculate comprehensive entropy weight values.

为评价指标计算熵权，生成权重列，计算熵权综合值。

## Usage
1. Run the *script*:

运行该*脚本*：
```
do "计算熵权.do"
```
2. Call function *entropy_weight*:

调用函数*entropy_weight*：
```
entropy_weight var_list , type(+|-) gen(new_var)
```

## Input
List of variables in the stata dataset.

stata数据集中的变量列表。

- type() option: "+" indicates that input variables are all positive indicators, "-" indicates negative indicators.
- type()选项："+"表示输入变量都是正向指标，"-"逆向指标。

gen(): Uses entropy weighting to calculate comprehensive values, generating a new variable named *new_var*

gen(): 利用熵权计算综合值，生成的新变量命名为*new_var*
 
## Output
Weights: Generate entropy weight columns corresponding to each variable, with names starting with "*ew_*".

权值：生成对应于各个变量的熵权列，名称以"*ew_*"开头。
  
Comprehensive evaluation value: Use the entropy weight method to calculate the variable list, obtain the entropy weight comprehensive value, named "*new_var*".

综合评价值：利用熵权法计算变量列表，得到熵权综合值，命名为"*new_var*"
