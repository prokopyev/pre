pre: An R package for deriving prediction rule ensembles
========================================================

pre is an R package for deriving prediction rule ensembles for binary and continuous outcome variables. Input variables may be numeric, ordinal and nominal. The package implements the algorithm for deriving prediction rule ensembles as described in Friedman & Popescu (2008), with several adjustments:

1.  The package is completely R based, allowing users better accessible results and more control over the parameters used for generating the prediction rule ensemble.
2.  The unbiased tree induction algorithm of Hothorn, Hornik, & Zeileis (2006) is used for deriving prediction rules, instead of the classification and regression tree (CART) algorithm, which suffers from biased variable selection.
3.  The package allows for plotting the final rule ensemble as a collection of simple decision trees.
4.  The initial ensemble of prediction rules can be generated as a bagged, boosted and/or random forest ensemble.
5.  Hinge functions of predictor variables may be included as baselearners in the ensemble, as in the multivariate adaptive regression splines technique of Friedman (1991).

The pre package is developed to provide useRs a completely R based implementation of the algorithm described by Friedman & Popescu (2008). However, note that pre is under development, and much work still needs to be done. See Fokkema, Smits, Kelderman, & Penninx (2015) for an application of the methods.

Examples
========

To get a first impression of how pre works, we will fit a prediction rule ensemble to predict Ozone levels using the airquality dataset:

``` r
library(pre)
complete <- complete.cases(airquality)
set.seed(42)
airq.ens <- pre(Ozone ~ ., data = airquality[complete, ], standardize = TRUE)
```

We can print the resulting ensemble:

``` r
print(airq.ens)
#> 
#> Final ensemble with cv error within 1se of minimum: 
#>   lambda =  4.17647
#>   number of terms = 18
#>   mean cv error (se) = 317.0573 (78.75351) 
#> 
#>          rule   coefficient                          description
#>   (Intercept)   67.15616051                                 <NA>
#>        rule72  -12.13055473              Wind > 5.7 & Temp <= 84
#>       rule213  -11.19466003              Wind > 5.1 & Temp <= 87
#>       rule216    7.38360232         Wind <= 10.3 & Solar.R > 148
#>         rule3    6.32585482              Temp > 78 & Wind <= 6.3
#>       rule179   -5.42658558              Wind > 5.7 & Temp <= 82
#>       rule122    4.66339857                            Temp > 77
#>       rule201   -4.55678752  Wind > 5.7 & Temp <= 87 & Day <= 23
#>       rule196   -4.08079273                           Wind > 5.7
#>        rule25   -3.77748826              Wind > 6.3 & Temp <= 82
#>        rule89    3.69069308              Temp > 77 & Wind <= 8.6
#>        rule76   -2.32587691              Wind > 6.3 & Temp <= 84
#>       rule119   -2.19972011                Wind > 8 & Temp <= 76
#>       rule212    1.95297306                        Solar.R > 201
#>       rule169   -1.20997908              Wind > 6.9 & Temp <= 82
#>        rule28   -0.34433752              Temp <= 84 & Wind > 7.4
#>       rule112   -0.27695874                Wind > 8 & Temp <= 77
#>       rule141   -0.21062503          Wind > 6.3 & Solar.R <= 115
#>       rule152   -0.01544867          Wind > 6.9 & Solar.R <= 149
```

We can plot the rules (and or/linear terms) in the ensemble:

``` r
plot(airq.ens, penalty.par.val = "lambda.1se", max.terms.plot = 9, cex = .6)
```

![](inst/README-figures/README-unnamed-chunk-4-1.png)![](inst/README-figures/README-unnamed-chunk-4-2.png)

We can obtain the estimated coefficients of the ensemble:

``` r
head(coef(airq.ens))
#>            rule coefficient                  description
#> 194 (Intercept)   67.156161                         <NA>
#> 56       rule72  -12.130555      Wind > 5.7 & Temp <= 84
#> 167     rule213  -11.194660      Wind > 5.1 & Temp <= 87
#> 170     rule216    7.383602 Wind <= 10.3 & Solar.R > 148
#> 3         rule3    6.325855      Temp > 78 & Wind <= 6.3
#> 140     rule179   -5.426586      Wind > 5.7 & Temp <= 82
```

We can assess the importance of the input variables and base learenrs in the ensemble:

``` r
importance(airq.ens, round = 4)
```

![](inst/README-figures/README-unnamed-chunk-6-1.png)

    #> $varimps
    #>   varname     imp
    #> 1    Wind 14.5468
    #> 2    Temp 13.7228
    #> 3 Solar.R  2.8625
    #> 4     Day  0.7364
    #> 
    #> $baseimps
    #>       rule                         description    imp coefficient     sd
    #> 1   rule72             Wind > 5.7 & Temp <= 84 5.5196    -12.1306 0.4550
    #> 2  rule213             Wind > 5.1 & Temp <= 87 4.4044    -11.1947 0.3934
    #> 3  rule216        Wind <= 10.3 & Solar.R > 148 3.6648      7.3836 0.4963
    #> 4  rule179             Wind > 5.7 & Temp <= 82 2.5518     -5.4266 0.4702
    #> 5  rule122                           Temp > 77 2.3307      4.6634 0.4998
    #> 6    rule3             Temp > 78 & Wind <= 6.3 2.2885      6.3259 0.3618
    #> 7  rule201 Wind > 5.7 & Temp <= 87 & Day <= 23 2.2092     -4.5568 0.4848
    #> 8   rule25             Wind > 6.3 & Temp <= 82 1.8005     -3.7775 0.4766
    #> 9   rule89             Temp > 77 & Wind <= 8.6 1.7090      3.6907 0.4630
    #> 10 rule196                          Wind > 5.7 1.2729     -4.0808 0.3119
    #> 11  rule76             Wind > 6.3 & Temp <= 84 1.0856     -2.3259 0.4667
    #> 12 rule119               Wind > 8 & Temp <= 76 1.0549     -2.1997 0.4796
    #> 13 rule212                       Solar.R > 201 0.9806      1.9530 0.5021
    #> 14 rule169             Wind > 6.9 & Temp <= 82 0.5921     -1.2100 0.4894
    #> 15  rule28             Temp <= 84 & Wind > 7.4 0.1698     -0.3443 0.4932
    #> 16 rule112               Wind > 8 & Temp <= 77 0.1349     -0.2770 0.4872
    #> 17 rule141         Wind > 6.3 & Solar.R <= 115 0.0919     -0.2106 0.4363
    #> 18 rule152         Wind > 6.9 & Solar.R <= 149 0.0072     -0.0154 0.4630

We can generate predictions for new observations:

``` r
airq.preds <- predict(airq.ens, newdata = airquality[1:4,])
```

We can assess the effect of a single predictor variable on the outcome through a partial dependence plot:

``` r
singleplot(airq.ens, varname = "Temp")
```

![](inst/README-figures/README-unnamed-chunk-8-1.png)

We can assess the effect of a par of predictor variables on the outcome through a partial dependence plot:

``` r
pairplot(airq.ens, varnames = c("Temp", "Wind"))
```

![](inst/README-figures/README-unnamed-chunk-9-1.png)

    #> NOTE: function pairplot uses package 'akima', which has an ACM license.
    #>     See also https://www.acm.org/publications/policies/software-copyright-notice.

We can assess the expected prediction error of the ensemble, by default calculated using 10-fold cross validation:

``` r
set.seed(43)
airq.cv <- cvpre(airq.ens)
airq.cv$accuracy
#> $MSE
#>       MSE        se 
#> 375.80814  85.76707 
#> 
#> $MAE
#>       MAE        se 
#> 14.079477  1.270563
```

More complex prediction ensembles can be derived with the gpe() function. The abbreviation gpe stands for generalized prediction ensembles, which may also include hinge functions of the predictor variables, in addition to rules and linear terms Friedman (1991). Addition of hinge functions may improve predictive accuracy (but may also reduce interpretability).

References
==========

Fokkema, M., Smits, N., Kelderman, H., & Penninx, B. W. (2015). Connecting clinical and actuarial prediction with rule-based methods. *Psychological Assessment*, *27*(2), 636.

Friedman, J. H. (1991). Multivariate adaptive regression splines. *The Annals of Statistics*, 1–67.

Friedman, J. H., & Popescu, B. E. (2008). Predictive learning via rule ensembles. *The Annals of Applied Statistics*, *2*(3), 916–954. Retrieved from <http://www.jstor.org/stable/30245114>

Hothorn, T., Hornik, K., & Zeileis, A. (2006). Unbiased recursive partitioning: A conditional inference framework. *Journal of Computational and Graphical Statistics*, *15*(3), 651–674.
