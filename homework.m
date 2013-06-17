delete log.txt
diary log.txt

diary off

load ps2.mat
load iv.mat



% Question. 1

s_o = []

n_brand = 24
n_market = 94


a = sum( s_jt( reshape( 1: size(s_jt, 1), [n_brand n_market] ) ) )

for k = 1: n_market
  s_o = [ s_o; ones(n_brand, 1) * ( 1 - a(k) ) ]
end

y = log(s_jt) - log(s_o)
x = x2
z = [x iv]

diary on

disp("Question 1")

[beta_ols, sigma_ols] = ols (y, x)
[beta_iv, sigma_iv] = ols (y, z)

diary off




% Question. 2

index_1 = find(x(:, 4) > 0)
index_0 = find(x(:, 4) < 1)

s_0 = s_jt
s_1 = s_jt

s_0(index_1, :) = 0
s_1(index_0, :) = 0

a_0 = sum( s_0( reshape( 1: size(s_0, 1), [n_brand n_market] ) ) )'
a_1 = sum( s_1( reshape( 1: size(s_1, 1), [n_brand n_market] ) ) )'


s_g_0 = kron( a_0, ones(n_brand, 1) )
s_g_1 = kron( a_1, ones(n_brand, 1) )

s_0 = s_0 ./ s_g_0 
s_1 = s_1 ./ s_g_1

s_g = s_0 + s_1

y = log(s_jt) - log(s_o)
x = [x s_g]
z = [x iv]

diary on

disp(" ")
disp("----------")
disp("Question 2")

[beta, sigma] = ols (y, z)

diary off




% Question. 3 





% Question. 4

zeta = rand(n_brand, 1)
error = kron( ones(n_market, 1), zeta )


beta = [-3.0; 10.0; 0.1; 0.05]
x = x2

y = x * beta + error

beta_hat = ols (y, x)


diary on

disp(" ")
disp("----------")
disp("Question 4")

zeta
beta
beta_hat

diary off


