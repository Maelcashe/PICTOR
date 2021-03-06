clear all , close all 
%%visualize instantaneous position of the particles
DataFolder='/Users/rahulkumar/Dropbox/NumericalCodes/PICTOR/data';
TimeSteps=100:100:1000;
%==========================================================================
CurrentFolder=pwd;
cd(DataFolder)

compe=double(h5read('param','/compe'));
resgrid=double(h5read('param','/resgrid'));
c=double(h5read('param','/c'));


for t=TimeSteps

FileName=strcat('prtl_',num2str(t));
x=h5read(FileName,'/x');
y=h5read(FileName,'/y');
z=h5read(FileName,'/z');
u=h5read(FileName,'/u');
v=h5read(FileName,'/v');
w=h5read(FileName,'/w');
a=h5read(FileName,'/a');
q=h5read(FileName,'/q');
flv=h5read(FileName,'/flv');

%ions
x1=x(flv==1);
y1=y(flv==1);
z1=z(flv==1);
u1=u(flv==1);
v1=v(flv==1);
w1=w(flv==1);

%electrons
x2=x(flv==2);
y2=y(flv==2);
z2=z(flv==2);
u2=u(flv==2);
v2=v(flv==2);
w2=w(flv==2);

g1=sqrt(1+u1.^2+v1.^2+w1.^2); % Loretnz factors of the ions
g2=sqrt(1+u2.^2+v2.^2+w2.^2); % Loretnz factors of the electrons
 if(~exist('h1'))
    figure('units','normalized','outerposition',[0 0 1 1]) 
    h1=plot(x2,y2,'.r','MarkerSize',1); %electrons
    set(h1,'XDataSource','x2','YDataSource','y2')
    hold on
    h2=plot(x1,y1,'.g','MarkerSize',1); %ions 
    set(h2,'XDataSource','x1','YDataSource','y1')
    axis equal
else
pause(0.0)
refreshdata(h1,'caller'); 
refreshdata(h2,'caller');
drawnow;
 end
 str=t*c/compe;
 title(strcat('t=',strcat(num2str(str),'\omega_{pe}^{-1}')))
 

end
cd(CurrentFolder)