opts = detectImportOptions("20220607_16.42_IntDen.csv");
preview("20220607_16.42_IntDen.csv", opts)
id = readmatrix("20220607_16.42_IntDen.csv", opts);
chambers = 160;
sm =[];
for i = 1:chambers
    plot1 = plot(id(:,1), id(:,i+1), 'r.');
    % Get xdata from plot
    xdata1 = get(plot1, 'xdata');
    % Get ydata from plot
    ydata1 = get(plot1, 'ydata');
    % Make sure data are column vectors
    xdata1 = xdata1(:);
    ydata1 = ydata1(:);
    fitResults1 = polyfit(xdata1,ydata1,1);
    slope1 = fitResults1(1,1);
    %slope matrix
    sm = [sm, slope1];
end
sm
histogram(sm)
ylabel({'Chamber Count'});
xlabel({'Slopes (fluoresence vs time) Bins'});