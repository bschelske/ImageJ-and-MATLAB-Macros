clear 
petdet = "test_petdet.csv";
intden = "test_intden.csv";
opts = detectImportOptions(petdet);
pd = readmatrix(petdet, opts);
opts = detectImportOptions(intden);
id = readmatrix(intden, opts);
nChambers = 160;
log = 0;
histo = 0;
Max = max(id,[],'all');
min_id = id;
min_id(:,1)=[];
Min = min(min_id,[],'all');
clear figure(1)
clear figure(2)
figure(1)
tiledlayout(8,20);
%zero code improves speed over [], apparently
cell_slope = zeros(1,160);
all_slope = zeros(1,160);
% cell_slope = [];
% all_slope = [];
for i=1:nChambers
    nexttile
    %petdet to green cell chambers
        if pd((i+1)) == 0
        color = ('k.');
        else 
            color = ('g.');
        end
    if log == 1
        y_log = log10(id(:,i+1));
          plot1 = plot(id(:,1), y_log, color);
    end
    if log == 0
        plot1 = plot(id(:,1), id(:,i+1), color);
    end
   axis([0 nChambers Min Max])
    set(gca,'xtick',[],'ytick',[]);
    b = num2str(i);
    title(b);
    if histo == 1
        xdata1 = get(plot1, 'xdata');
        ydata1 = get(plot1, 'ydata');
        xdata1 = xdata1(:);
        ydata1 = ydata1(:);
        fitResults1 = polyfit(xdata1,ydata1,1);
        slope1 = fitResults1(1,1);
        %slope matrix
            if pd((i+1)) == 1
                cell_slope = [cell_slope, slope1];
            end
        all_slope = [all_slope, slope1];
    end
end
if histo == 1
figure(2)
tiledlayout(1,2);
nexttile;
histogram(all_slope);
title('All Slope')
nexttile;
histogram(cell_slope);
title('Cell Slope')
end
