delete log.txt
diary log.txt

diary off

load ps2.mat
load iv.mat

s_0 = []

n_brand = 24
n_market = 94

for k = 1: n_market 
  sum = 0
  for i = k: k - 1 + n_brand
    sum = sum + s_jt(i, :)
  end
  s_0 = [ s_0; ones(n_brand, 1) * (1 - sum)]
end

y = log(s_jt) - log(s_0)
x = x2
z = [x iv]

diary on

disp("Question 1")

[beta_ols, sigma_ols] = ols (y, x)
[beta_iv, sigma_iv] = ols (y, z)

diary off

index_1 = find(x(:, 4) > 0)
index_0 = find(x(;, 4) < 1)

g_0 = s_jt(index_0, :)
g_1 = s_jt(index_1, :)

