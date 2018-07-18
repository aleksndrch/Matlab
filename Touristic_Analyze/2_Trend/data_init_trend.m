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
ddata_s   =struct('fin_cris',1,'ru_cris',2,'int_sanction',3);

%Years for reseach:
years=2008:1:2016;

%Import data block:
%Calculate data size and save it. For faster compute save imported data
%in .mat files ("IF" data_changed_f==1 load data from Excel):
%data_size.mat  - for data sizes struct   (rb,cb,N)
%bdata.mat      - for base and dummy data (Y,X1,X2,X3,X4,D1,D2,D3)
%ddata.mat      - for dummy variables (D1,D2,D3)

if data_changed_f==1
    %Data size constant (struct):
    [~, sheets]=xlsfinfo('input_data_trend.xlsx'); 
    bdata_size=struct...
        ('rb',length(years),...               %Num of years
         'cb',length(struct2cell(bdata_s)),...%Num of variables
         'N',length(sheets));                 %Num of countries
    bdata=zeros(bdata_size.rb,bdata_size.cb,bdata_size.N);
    save('data_size_trend.mat','bdata_size');

%Import data:
%BASE:
    for k=1:bdata_size.N
         bdata(:,:,k)=xlsread('input_data_trend.xlsx',k,'M4:Q12');
         save('bdata_trend.mat','bdata');
    end
%DUMMY (the same for all coutries)
    ddata=xlsread('input_data_trend.xlsx',cntry_s.CN,'R4:T12');
    save('ddata_trend.mat','ddata');
%("ELSE" data_changed_f==0 load data from .mat files):
else 
    load('bdata_trend.mat');      %Base  data
    load('ddata_trend.mat');      %Dummy data
    load('data_size_trend.mat');  %Array size
end

