hN = [1 0 0 0 0 0 0 0 0 0 0];
hD = [1 0 0 0 0 0 0 0 0 0 -0.96];
tf = poly2sym(hN)/poly2sym(hD);
fs = 8000;
index = 1;
for w = 0:pi/64:pi;
    z = exp(1i*w);
    
    response(index) = eval(subs(tf,z));
    disp(z);disp(response(index));
    index = index + 1;
end
plot(index,mag2db(abs(response)))

    
    





    






