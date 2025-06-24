*! entropy_weight
*! version: 2.0
*! Date: 24.June.2025
*! Author: Frank Sun (frank.sun.319@gmail.com)

cap program drop entropy_weight
program define entropy_weight
	syntax varlist [ , type(string) gen(string)]
	
	* 步0：检查生成变量
	if "`gen'"== "" {
		di as error `"USAGE: entropy_weight var_list , type(+|-) gen(output_var)"'
		exit
	}
	cap confirm variable `gen'
	if !_rc {
		di as error "变量`gen'已存在"
		exit
	}
	
	foreach var of varlist `varlist' {
		* 步1：标准化变量，已标准化
		cap drop std_`var'
		quietly sum `var'
		if "`type'"=="+" {
			gen std_`var' = `var'/r(max)
		}
		else if "`type'"=="-" {
			gen std_`var' = r(min)/`var'
		}
		else {
			di as error `"USAGE: entropy_weight var_list , type(+|-) gen(output_var)"'
			exit
		}
		
		* 步2：计算变量频率（概率）
		cap drop total_`var'
		egen total_`var' = total(std_`var')
		cap drop freq_`var'
		gen freq_`var' = std_`var'/total_`var'
		
		* 步3：计算变量的熵值		
		cap drop plnp_`var'
		gen plnp_`var' = freq_`var'*ln(freq_`var')
		cap drop entropy_`var'
		egen entropy_`var' = total(plnp_`var')
		quietly replace entropy_`var' = -entropy_`var'/ln(_N)
		
		* 步4：计算变量差异系数
		cap drop var_`var'
		gen var_`var' = 1 - entropy_`var'		
	}
	
	* 步5：定义权重
	cap drop total_var
	gen total_var = 0
	foreach var of varlist `varlist' {
		quietly replace total_var = total_var + var_`var'
	}
	foreach var of varlist `varlist' {
		cap drop ew_`var'
		gen ew_`var' = var_`var'/total_var
		lab var ew_`var' "变量`var'熵权"
	}

	* 步6：计算综合评价值
	gen `gen' = 0
	foreach var of varlist `varlist' {
		quietly replace `gen' = `gen' + ew_`var'*freq_`var'
		lab var `gen' "生变熵权综合变量`gen'"
	}	
	
	* 步7：清理临时变量
	foreach var of varlist `varlist' {
		cap drop std_`var'
		cap drop total_`var'
		cap drop freq_`var'
		cap drop plnp_`var'
		cap drop entropy_`var'
		cap drop var_`var'
	}
	cap drop total_var
end

/* Example
entropy_weight x1 x2 x3 , type(+) gen(y)
*/