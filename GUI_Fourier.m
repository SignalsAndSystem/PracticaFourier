function GUI_Fourier
% Este programa es una interfaz de usuario acoplada al programa que calcula
% los coeficientes de fourier

%  Se crea la ventana de interfaz de usuario
g = figure('Visible','off','Position',[360,500,800,650]);

% Se crean y dan las especificaciones de los coponentes

Calcular = uicontrol('Style','pushbutton',...
             'String','Elegir','Position',[1000,500,70,25],...
             'Callback',@Calcular_Callback);
text1  = uicontrol('Style','text','String','Selecciona tu funcion',...
           'Position',[325,400,200,15]);
autor1  = uicontrol('Style','text','String','Diego Uribe Muñiz',...
           'Position',[600,200,200,15]);
autor2  = uicontrol('Style','text','String','Andres Garcia Rubio',...
           'Position',[600,180,200,15]);
hpopup = uicontrol('Style','popupmenu',...
           'String',{'f(x) = 1- x/2 [0,2]', 'f(x) = x^2 [-1,1]', 'f(x) = x [-pi,pi]', 'f(x) = 1 [-pi,0] 2 [0,pi]', 'f(x) = 0 [-pi,0] sin(x) [0,pi]','f(x) = exp(x)','f(x) = 0 [-pi,0] x [0,pi]','f(x) = abs(x)'},...
           'Position',[300,350,200,25],...
           'Callback',@popup_menu_Callback);
txtbox = uicontrol(g,'Style','edit',...
                'String','Ingrese un Valor de k',...
                'Position',[600 300 200 20]);

%Se dan los parametros del grafico y se alinean los botones
ha = axes('Units','pixels','Position',[50,100,500,500]);
align([Calcular,text1,hpopup,txtbox,autor1,autor2],'Center','None');

% Se normalizan los datos de los componentes para que cambien de tamaño
% automaticamente
g.Units = 'normalized';
Calcular.Units = 'normalized';
text1.Units = 'normalized';
hpopup.Units = 'normalized';

% se generan vectores vacion iniciales
plot_init= (zeros(5));
funcion = zeros(5);


% Se crea un vector para guardar las funciones
current_data = plot_init;
plot(current_data);

% Se pone el nombre dle programa en la ventana principal
g.Name = 'Practica Fourier';

% Se mueve la ventana al centro
movegui(g,'center')

% Se hace visible la ventana
g.Visible = 'on';

%  Pop-up menu callback.Esta funcion corre cada vez que se cambia de
%  funcion en el menu
   function popup_menu_Callback(source,eventdata) 
   
%Se crea un vector t para definir numéricamente el dominio, se crea un
%vector vacío para guardar los datos dela suma y se le piden los
%parámetros a la interfaz   
       
   f = get(source,'Value');
   k = str2double(get(txtbox, 'string'));
   t=-5:.01:5;
   s = 0 * t; 

%El siguiente FOR crea un vector diferente para cada valor k, y los agrega
%a la suma 

   for i = 0:k,
    %este switch decide la funcion y lo parametros para calcular el valor
    %k esimo de la serie utilizando el parametro dado por el usuario
    switch f
        case 1
            cd = 1/2;
            a = 0;
            b = (i*pi)/((i^2)*(pi^2)); 
            w = pi;
            funcion = 1- t/2;
        case 2
            cd = 1/3;
            a = (4*i*pi*((-1)^(i)))/((i^3)*(pi^3));
            b = 0;
            w = pi;
            funcion = t.^2;
        case 3
            cd = 0;
            a = 0;
            b = (-2*i*pi*((-1)^(i)))/((i^2)*pi);
            w = 1;
            funcion = t;
        case 4
            cd = 3/2;
            a = 0;
            b = 2*(1-((-1)^(i)))/(2*i*pi);  
            w = 1;
            funcion = heaviside(-t) + 2* heaviside(t);
        case 5
            cd = (1/pi);
            a = (1+((-1)^(i)))/(pi-((i^2)*pi));
            b = 0;  
            w = 1;
            funcion = (sin(t)).* heaviside(t);
        case 6
            cd = 3.676;
            a = (1/pi)*2*(sinh(pi)*((-1)^(i)))/(i^2 + 1);
            b = (1/pi)*(-2*i*sinh(pi)*((-1)^(i)))/(1+i^2); 
            w = 1;
            funcion = exp(t);
        case 7
            cd = pi/4;
            a = (1/pi)*(((-1)^(i))-1)/i^2;
            b = (1/pi)*(-pi*i*((-1)^(i)))/i^2; 
            w = 1;
            funcion = t.* heaviside(t);
        case 8
            cd = pi/2;
            a = (2*(((-1)^(i))-1))/(pi*i^2);
            b = 0;    
            w = 1;
            funcion = -(t.* heaviside(-t)) + t.* heaviside(t);
    end
     
    %usando los coeficientes de la serie de fouirier, se evalúan los
    %diferentes elementos de la seri, el valor k = 1 de la funcion 5 es un
    %caso especial (division entre 0) asi que es calculado por separado
    
     if i == 0
          s = s + cd ;
     elseif ~(f == 5 && i == 1)
          z = a * cos(w*t*i) + b * sin(w*t*i);
          s = s + z ;
     else 
          z = (1/2)*sin(w*t);
          s = s + z ;
     end
   end
   current_data = s;
end

  %Se grafica al momento que el usuario oprime el boton calcular
  

  function Calcular_Callback(source,eventdata) 
        ejex=-5:.01:5;
       plot(ejex,current_data,ejex,funcion)
       grid on;
       
  end


end