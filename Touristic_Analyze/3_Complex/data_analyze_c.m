%File using struct:
%bdata_s (arrivals income  price currency trend])
%ddata_s (fin_cris ru_cris int_sanction)

%Load data fo analyze:
data_init_c;

%Regression analize (regstats) for each country(1->N) and base variables,
%using output next variables (struct): (x)=b for base, (x)=d for dummy:
%out(x)_lin   - Constant and linear
%out(x)_inter - Constant, linear, and interaction terms
%out(x)_pq    - Constant, linear, and squared terms

for k=1:bdata_size.N
    Y=bdata(:,bdata_s.arrivals,k);                             %Output

    %For base data:
    Xb=bdata(:,[bdata_s.income,  bdata_s.price,...
                bdata_s.currency,bdata_s.trend,...
                ddata_s.fin_cris,ddata_s.ru_cris,...
                ddata_s.int_sanction], k);                         %Input
    %Calculation:       
    outb_lin(k)   =regstats(Y,Xb,'linear','all');
 end

%Output:
%Label for result tables:
label_tstat={'beta','se','t','p_val'};
label_fdwr={'sse','dfe','dfr','ssr','f','pval',...
            'dw','pval',...
            'R2','R2_adj','MSE'};
label_country={'CN','SK','JP','MG','GM','FR','UK','PL','US','AU'};

%Create array for each type of statistics (T,F,DW,R):
%T-Statistics:
%Linear:
%Define matrix sizes:
outb_ltstat_beta=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);
outb_ltstat_se=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);
outb_ltstat_t=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);
outb_ltstat_pval=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);

for k=1:bdata_size.N
   for j=1:length(outb_lin(cntry_s.CN).tstat.beta)
       %BASE:
       outb_ltstat_beta(j,k)=outb_lin(k).tstat.beta(j);
       outb_ltstat_se(j,k)  =outb_lin(k).tstat.se(j);
       outb_ltstat_t(j,k)   =outb_lin(k).tstat.t(j);
       outb_ltstat_pval(j,k)=outb_lin(k).tstat.pval(j);
   end
end
%Vektorize recieved data and create matrix:
outb_lin_tstat=[outb_ltstat_beta(:) outb_ltstat_se(:)...
                outb_ltstat_t(:)    outb_ltstat_pval(:)];
clear outb_ltstat_beta outb_ltstat_se outb_ltstat_t outb_ltstat_pval

%F-Statistics:
%Define matrix sizes:
outb_lin_fstat=zeros(bdata_size.N,6);

for k=1:bdata_size.N
    %Linear:
    outb_lin_fstat(k,:)=struct2array(outb_lin(k).fstat);
end

%DW-Statistics:
%Define matrix sizes:
outb_lin_dwstat=zeros(bdata_size.N,2);
for k=1:bdata_size.N
    %Linear:
    outb_lin_dwstat(k,:)=struct2array(outb_lin(k).dwstat);
end

%R-statistics:
%Define matrix sizes:
outb_lin_rstat=zeros(bdata_size.N,3);
for k=1:bdata_size.N
    %Linear:
    outb_lin_rstat(k,1)=outb_lin(k).rsquare;
    outb_lin_rstat(k,2)=outb_lin(k).adjrsquare;
    outb_lin_rstat(k,3)=outb_lin(k).mse;
end

%Combine F,DW,R stat:
outb_lin_fdwr  = [outb_lin_fstat outb_lin_dwstat outb_lin_rstat];
clear outb_lin_fstat outb_lin_dwstat outb_lin_rstat

%Plot residuals vs. fitted values for China
for k=1:bdata_size.N
    figure(1)
    subplot(2,5,k)
    scatter(outb_lin(k).yhat,outb_lin(k).r)
    title(label_country(k));
    xlabel('Fitted Values'); ylabel('Residuals');
end


% %Result output (to Excel):
% %Linear(Base):
% xlswrite('out_data_c.xlsx',label_tstat,1,'B2')
% xlswrite('out_data_c.xlsx',outb_lin_tstat,1,'B3')
% xlswrite('out_data_c.xlsx',label_fdwr,1,'H2')
% xlswrite('out_data_c.xlsx',outb_lin_fdwr,1,'H3')



