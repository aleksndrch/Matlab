%File using struct:
%bdata_s (arrivals income  price currency trend])
%ddata_s (fin_cris ru_cris int_sanction)

%Load data fo analyze:
data_init;

%Regression analize (regstats) for each country(1->N) and base variables,
%using output next variables (struct): (x)=b for base, (x)=d for dummy:
%out(x)_lin   - Constant and linear
%out(x)_inter - Constant, linear, and interaction terms
%out(x)_pq    - Constant, linear, and squared terms

for k=1:bdata_size.N
    Y=bdata(:,bdata_s.arrivals,k);                             %Output
    %For base data:
    Xb=bdata(:,[bdata_s.income, bdata_s.price,...
                bdata_s.currency], k);                         %Input
    %Calculation:       
    outb_lin(k)   =regstats(Y,Xb,'linear','all');
    outb_inter(k) =regstats(Y,Xb,'interaction','all');
    outb_pq(k)    =regstats(Y,Xb,'purequadratic','all');
    
    %For dummy data:
    Xd=ddata;                                                  %Input
    %Calculation:       
    outd_lin(k)   =regstats(Y,Xd,'linear','all');
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

outd_ltstat_beta=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);
outd_ltstat_se=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);
outd_ltstat_t=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);
outd_ltstat_pval=zeros(length(outb_lin(cntry_s.CN).tstat.beta),bdata_size.N);

for k=1:bdata_size.N
   for j=1:length(outb_lin(cntry_s.CN).tstat.beta)
       %BASE:
       outb_ltstat_beta(j,k)=outb_lin(k).tstat.beta(j);
       outb_ltstat_se(j,k)  =outb_lin(k).tstat.se(j);
       outb_ltstat_t(j,k)   =outb_lin(k).tstat.t(j);
       outb_ltstat_pval(j,k)=outb_lin(k).tstat.pval(j);
       %DUMMY:
       outd_ltstat_beta(j,k)=outd_lin(k).tstat.beta(j);
       outd_ltstat_se(j,k)  =outd_lin(k).tstat.se(j);
       outd_ltstat_t(j,k)   =outd_lin(k).tstat.t(j);
       outd_ltstat_pval(j,k)=outd_lin(k).tstat.pval(j);
   end
end
%Vektorize recieved data and create matrix:
outb_lin_tstat=[outb_ltstat_beta(:) outb_ltstat_se(:)...
                outb_ltstat_t(:)    outb_ltstat_pval(:)];
outd_lin_tstat=[outd_ltstat_beta(:) outd_ltstat_se(:)...
                outd_ltstat_t(:)    outd_ltstat_pval(:)];            
clear outb_ltstat_beta outb_ltstat_se outb_ltstat_t outb_ltstat_pval
clear outd_ltstat_beta outd_ltstat_se outd_ltstat_t outd_ltstat_pval

%Interaction and Purequadratic:
%Define matrix sizes:
out_itstat_beta=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_itstat_se=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_itstat_t=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_itstat_pval=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_pqtstat_beta=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_pqtstat_se=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_pqtstat_t=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);
out_pqtstat_pval=zeros(length(outb_inter(cntry_s.CN).tstat.beta),bdata_size.N);

for k=1:bdata_size.N
   for j=1:length(outb_inter(cntry_s.CN).tstat.beta)
       %Interaction:
       out_itstat_beta(j,k)=outb_inter(k).tstat.beta(j);
       out_itstat_se(j,k)  =outb_inter(k).tstat.se(j);
       out_itstat_t(j,k)   =outb_inter(k).tstat.t(j);
       out_itstat_pval(j,k)=outb_inter(k).tstat.pval(j); 
       %Purequadratic:
       out_pqtstat_beta(j,k)=outb_pq(k).tstat.beta(j);
       out_pqtstat_se(j,k)  =outb_pq(k).tstat.se(j);
       out_pqtstat_t(j,k)   =outb_pq(k).tstat.t(j);
       out_pqtstat_pval(j,k)=outb_pq(k).tstat.pval(j);
   end
end

%Vektorize recieved data and create matrix:
outb_inter_tstat=[out_itstat_beta(:) out_itstat_se(:)...
                  out_itstat_t(:)    out_itstat_pval(:)];
outb_pq_tstat   =[out_pqtstat_beta(:) out_pqtstat_se(:)...
                  out_pqtstat_t(:)    out_pqtstat_pval(:)];            
clear out_itstat_beta out_itstat_se out_itstat_t out_itstat_pval
clear out_pqtstat_beta out_pqtstat_se out_pqtstat_t out_pqtstat_pval

%F-Statistics:
%Define matrix sizes:
outb_lin_fstat=zeros(bdata_size.N,6);
outd_lin_fstat=zeros(bdata_size.N,6);
outb_inter_fstat=zeros(bdata_size.N,6);
outb_pq_fstat=zeros(bdata_size.N,6);
for k=1:bdata_size.N
    %Linear:
    outb_lin_fstat(k,:)=struct2array(outb_lin(k).fstat);
    outd_lin_fstat(k,:)=struct2array(outd_lin(k).fstat);
    %Interaction:
    outb_inter_fstat(k,:)=struct2array(outb_inter(k).fstat);
    %Purequadratic:
    outb_pq_fstat(k,:)=struct2array(outb_pq(k).fstat);
end

%DW-Statistics:
%Define matrix sizes:
outb_lin_dwstat=zeros(bdata_size.N,2);
outd_lin_dwstat=zeros(bdata_size.N,2);
outb_inter_dwstat=zeros(bdata_size.N,2);
outb_pq_dwstat=zeros(bdata_size.N,2);
for k=1:bdata_size.N
    %Linear:
    outb_lin_dwstat(k,:)=struct2array(outb_lin(k).dwstat);
    outd_lin_dwstat(k,:)=struct2array(outd_lin(k).dwstat);
    %Interaction:
    outb_inter_dwstat(k,:)=struct2array(outb_inter(k).dwstat);
    %Purequadratic:
    outb_pq_dwstat(k,:)=struct2array(outb_pq(k).dwstat);
end

%R-statistics:
%Define matrix sizes:
outb_lin_rstat=zeros(bdata_size.N,3);
outd_lin_rstat=zeros(bdata_size.N,3);
outb_inter_rstat=zeros(bdata_size.N,3);
outb_pq_rstat=zeros(bdata_size.N,3);
for k=1:bdata_size.N
    %Linear:
    outb_lin_rstat(k,1)=outb_lin(k).rsquare;
    outb_lin_rstat(k,2)=outb_lin(k).adjrsquare;
    outb_lin_rstat(k,3)=outb_lin(k).mse;
    
    outd_lin_rstat(k,1)=outd_lin(k).rsquare;
    outd_lin_rstat(k,2)=outd_lin(k).adjrsquare;
    outd_lin_rstat(k,3)=outd_lin(k).mse;
    
    %Interaction:
    outb_inter_rstat(k,1)=outb_inter(k).rsquare;
    outb_inter_rstat(k,2)=outb_inter(k).adjrsquare;
    outb_inter_rstat(k,3)=outb_inter(k).mse;
    %Purequadratic:
    outb_pq_rstat(k,1)=outb_pq(k).rsquare;
    outb_pq_rstat(k,2)=outb_pq(k).adjrsquare;
    outb_pq_rstat(k,3)=outb_pq(k).mse;
end

%Combine F,DW,R stat:
outb_lin_fdwr  = [outb_lin_fstat outb_lin_dwstat outb_lin_rstat];
outd_lin_fdwr  = [outd_lin_fstat outd_lin_dwstat outd_lin_rstat];
outb_inter_fdwr= [outb_inter_fstat outb_inter_dwstat outb_inter_rstat];
outb_pq_fdwr   = [outb_pq_fstat outb_pq_dwstat outb_pq_rstat];
clear outb_lin_fstat outb_lin_dwstat outb_lin_rstat
clear outd_lin_fstat outd_lin_dwstat outd_lin_rstat
clear outb_inter_fstat outb_inter_dwstat outb_inter_rstat
clear outb_pq_fstat outb_pq_dwstat outb_pq_rstat


%Plot residuals vs. fitted values for China
figure(1)
for k=1:bdata_size.N
    subplot(2,5,k)
    scatter(outb_lin(k).yhat,outb_lin(k).r)
    title(label_country(k));
    xlabel('Fitted Values'); ylabel('Residuals');
    
end

% %Result output (to Excel):
% %Linear(Base):
% xlswrite('out_data.xlsx',label_tstat,1,'B2')
% xlswrite('out_data.xlsx',outb_lin_tstat,1,'B3')
% xlswrite('out_data.xlsx',label_fdwr,1,'H2')
% xlswrite('out_data.xlsx',outb_lin_fdwr,1,'H3')
% %Linear(Dummy):
% xlswrite('out_data.xlsx',label_tstat,2,'B2')
% xlswrite('out_data.xlsx',outd_lin_tstat,2,'B3')
% xlswrite('out_data.xlsx',label_fdwr,2,'H2')
% xlswrite('out_data.xlsx',outd_lin_fdwr,2,'H3')
% %Interaction:
% xlswrite('out_data.xlsx',label_tstat,3,'B2')
% xlswrite('out_data.xlsx',outb_inter_tstat,3,'B3')
% xlswrite('out_data.xlsx',label_fdwr,3,'H2')
% xlswrite('out_data.xlsx',outb_inter_fdwr,3,'H3')
% %Purequadratic:
% xlswrite('out_data.xlsx',label_tstat,4,'B2')
% xlswrite('out_data.xlsx',outb_pq_tstat,4,'B3')
% xlswrite('out_data.xlsx',label_fdwr,4,'H2')
% xlswrite('out_data.xlsx',outb_pq_fdwr,4,'H3')


