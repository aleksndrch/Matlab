function x_new=obj_def(x)
x_new(1,1)=x(1);
x_new(2,1)=x(2)+sin(0.1*x(1));