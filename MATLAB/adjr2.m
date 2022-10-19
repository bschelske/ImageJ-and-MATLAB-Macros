tic
'fdsji' 
opts = detectImportOptions("PETDetectiveThreshold.csv");
% preview("PETDetectiveThreshold.csv", opts)
pd = readmatrix("PETDetectiveThreshold.csv", opts);
opts = detectImportOptions("20220607_16.42_IntDen.csv");
% preview("20220607_16.42_IntDen.csv", opts)
id = readmatrix("20220607_16.42_IntDen.csv", opts);
multiplot = true;
chambers = 160;
p = 3; 
clear figure(1)
clear figure(2)
figure(1)
tiledlayout(8,20);
%commented code improves speed over [], apparently
% cell_slope = nan(160,1) ;
% all_slope = nan(160,1);
cell_slope = [] ;
all_slope =[];
I = [];
rsq_adj = [];
for i=1:chambers 
    x = id(:,1);
    y = id(:,i+1);
    coefficients = polyfit(x,y,p);
    yFit = polyval(coefficients , x);
    yresid = y - yFit;
    ssresid = sum(yresid.^2);
    sstotal = (length(y)-1)*var(y);
    rsq1 = 1-ssresid/sstotal;
    rsq_adj1 = 1- ssresid/sstotal * (length(y)-1)/(length(y)-length(coefficients));
    rsq_adj = [rsq_adj;rsq_adj1];
    if multiplot == true
        nexttile
            if pd((i+1)) == 0
            color = ('k.');
            else 
                color = ('g.');
            end
        plot1 = plot(x,y, color);
        hold on
        coefficients = polyfit(x,y,p);
        plot(x,yFit, 'r-', 'LineWidth', 1);
        set(gca,'xtick',[],'ytick',[]);
        title(rsq1);
        hold off
    end
   
    I = [I;i];
end
T = table(I,rsq_adj,'VariableNames',{'Chamber','Adjusted RSQ',})

toc

