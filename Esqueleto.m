clear all
clc

t=-10:0.01:10;

s = 0 * t; 

k = input('Inserta K \n');
f = input('Inserta tu funcion \n');  

for i = 1:k,

    switch f
        case 1
            cd = 0;
            a = 0; 
            b = -(1/(pi*i));
        case 2
            cd = 0;
            a = 0;
            b = 0;    
        case 3
            cd = 0;
            a = 0;
            b = 0;
        case 4
            cd = 0;
            a = 0;
            b = 0;  
        case 5
            cd = 0;
            a = 0;
            b = 0;  
        case 6
            cd = 0;
            a = 0;
            b = 0;  
        case 7
            cd = 0;
            a = 0;
            b = 0;  
        case 8
            cd = 0;
            a = 0;
            b = 0;            
    end 

z = a * cos(2*pi*t*i) + b * sin(2*pi*t*i);

s = s + z ;


end

s = s +0.5;
plot(t ,s)
axis([-4 4 -2 3])
grid on