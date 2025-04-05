/*
	Description: 使用熵权法（熵值法）计算合成计算评价指标
	Structure:
		- 输入：需要计算的数值型变量列表，var_list
		- 输出：生成以"ew_"开头命名的权重列
	Author: frank.sun.319@gmail.com
	Version: 2025/04/05 rev3
*/

cap program drop entropy_weight
program define entropy_weight
	syntax varlist [if] [in] [ , dir(string)]
	
	foreach var of varlist `varlist' {
		* 步1：标准化变量，已标准化
		cap drop std_`var'
		quietly sum `var'
		if "`dir'"=="" {
			di `"USAGE: entropy_weight var_list [if] [in] , dir("a"|"d")"'
			exit
		}
		else if "`dir'"=="a" {
			gen std_`var'=`var'/r(max)
		}
		else if "`dir'"=="d" {
			gen std_`var'=r(min)/`var'
		}
		
		* 步2：计算变量频率（概率）
		cap drop total_`var'
		egen total_`var'=total(std_`var')
		cap drop freq_`var'
		gen freq_`var'=std_`var'/total_`var'
		
		* 步3：计算变量的熵值
		
		cap drop plnp_`var'
		gen plnp_`var'=freq_`var'*ln(freq_`var')
		cap drop entropy_`var'
		egen entropy_`var'=total(plnp_`var')
		replace entropy_`var'=-entropy_`var'/ln(_N)
		
		* 步4：计算变量差异系数
		cap drop g_`var'
		gen g_`var'=1-entropy_`var'
	}
	
	* 步5：定义权重
	cap drop total_g
	gen total_g=0
	foreach var of varlist `varlist' {
		replace total_g=total_g+g_`var' if g_`var'!=.
	}
	foreach var of varlist `varlist' {
		cap drop ew_`var'
		gen ew_`var'=g_`var'/total_g
	}

	* 步6：清理临时变量
	foreach var of varlist `varlist' {
		cap drop std_`var'
		cap drop total_`var'
		cap drop freq_`var'
		cap drop plnp_`var'
		cap drop entropy_`var'
		cap drop g_`var'
	}
	cap drop total_g
end