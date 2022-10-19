tic
disp('PolyRSQ Activated')
opts = detectImportOptions("PETDetectiveThreshold.csv");
    % preview("PETDetectiveThreshold.csv", opts)
    petDetMatrix = readmatrix("PETDetectiveThreshold.csv", opts);
    opts = detectImportOptions("20220607_16.42_IntDen.csv");
    % preview("20220607_16.42_IntDen.csv", opts)
    intDenMatrix = readmatrix("20220607_16.42_IntDen.csv", opts);
    multiplot = true;
    nChambers = 160;
    p = 1; 
    clear figure(1)
    clear figure(2)
    figure(2)
    tiledlayout(8,20);
    %commented code improves speed over [], apparently
    % cell_slope = nan(160,1) ;
    % all_slope = nan(160,1);
    cell_slope = [] ;
    all_slope =[];
    I = [];
    rsq = [];


for nChamber=1:nChambers 
    x = intDenMatrix(:,1);
    y = intDenMatrix(:,nChamber+1);
    coefficients = polyfit(x,y,p);
    yFit = polyval(coefficients , x);
    yresid = y - yFit;
    ssresid = sum(yresid.^2);
    sstotal = (length(y)-1)*var(y);
    rsq1 = 1-ssresid/sstotal;
    rsq = [rsq;rsq1];

    if multiplot == true
        nexttile
        
        if petDetMatrix((nChamber+1)) == 0 %pet det
            color = ('k.');
        else 
            color = ('g.');
        end %pet det

        plot1 = plot(x,y, color);
        hold on
        plot(x,yFit, 'r-', 'LineWidth', 1);
        set(gca,'xtick',[],'ytick',[]);
        title(rsq1);
        hold off
    end
   
    I = [I;nChamber];
end %nChambers for loop
T = table(I,rsq,'VariableNames',{'Chamber','RSQ',})

toc

