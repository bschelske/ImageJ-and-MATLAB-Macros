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
figure(2)
tiledlayout(8,20);
cell_slope = [] ;
all_slope =[];
I = [];
rsq = [];
for i=1:chambers 
    x = id(:,1);
    y = id(:,i+1);
    coefficients = polyfit(x,y,p);
    yFit = polyval(coefficients , x);
    yresid = y - yFit;
    ssresid = sum(yresid.^2);
    sstotal = (length(y)-1)*var(y);
    rsq1 = 1-ssresid/sstotal;
    rsq = [rsq;rsq1];
    if multiplot == true
        nexttile
            if pd((i+1)) == 0
            color = ('k.');
            else 
                color = ('g.');
            end
        plot1 = plot(x,y, color);
        hold on
        der = polyder(coefficients);
        yder = polyval(der,x);
        plot(x,yder, 'r-', 'LineWidth', 1);
        set(gca,'xtick',[],'ytick',[]);
        title(num2str(i));
        hold off
    end
   
    I = [I;i];
end


