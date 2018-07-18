%Workspace clean and intialize data:
clear all;
%Data changed? Use 0 if NO, and 1 if YES:
data_changed_f=0;   
%Create data structure and year vector for convinience:
%Reseach country name:
cntry_s=struct('CN',1,'SK',2,'JP',3,'MG',4,'GM',5,...
             'FR',6,'UK',7,'PL',8,'US',9,'AU',10);       
%Base data (ln) name:
%                   Y             X1         X2         X3        
bdata_s   =struct('arrivals',1,'income',2,'price',3,'currency',4,'trend',5);

%Dummy variables name:
%                    D1             D2            D3 
ddata_s   =struct('fin_cris',6,'ru_cris',7,'int_sanction',8);

%Years for reseach:
years=2008:1:2016;

%Import data block:
%Calculate data size and save it. For faster compute save imported data
%in .mat files ("IF" data_changed_f==1 load data from Excel):
%data_size.mat  - for data sizes struct   (rb,cb,N)
%bdata.mat      - for base and dummy data (Y,X1,X2,X3,X4,D1,D2,D3)

if data_changed_f==1
    %Data size constant (struct):
    [~, sheets]=xlsfinfo('input_data_c.xlsx'); 
    bdata_size=struct...
        ('rb',length(years),...               %Num of years
         'cb',length(struct2cell(bdata_s))...
             +length(struct2cell(ddata_s)),...%Num of variables
         'N',length(sheets));                 %Num of countries
    bdata=zeros(bdata_size.rb,bdata_size.cb,bdata_size.N);
    save('data_size_c.mat','bdata_size');

%Import data:
%BASE:
    for k=1:bdata_size.N
         bdata(:,:,k)=xlsread('input_data_c.xlsx',k,'M4:T12');
         save('bdata_c.mat','bdata');
    end
%("ELSE" data_changed_f==0 load data from .mat files):
else 
    load('bdata_c.mat');      %Base  data
    load('data_size_c.mat');  %Array size
end

