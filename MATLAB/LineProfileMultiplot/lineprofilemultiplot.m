function lineprofilemultiplot(myFilePath, histo,color)
    %Multiplot for varying lentgh line profile gradient from circle pro 2
    opts = detectImportOptions(myFilePath);
    dataset = readmatrix(myFilePath, opts); %row = pixel. col = chamber
    maxIntensity = max(dataset,[],'all');
    datasetSize = size(dataset);
    nColumns = (datasetSize(1,2) -1)/8; %assumed 8 rows of device to calculate cols
    f1 = tiledlayout(8,nColumns);
    datasetMin = dataset;
    datasetMin(:,1)=[];
    minIntensity = min(datasetMin,[],'all');
    slopeArray = zeros(1,(datasetSize(1,2)-1)); %histogram preallocation    
    figure(1)
    a = 'Chamber'; %used later for title of each plot
    for i=1:(datasetSize(1,2)-1)
      nexttile
      plot1 = plot(dataset(:,1), dataset(:,i+1), color);
      axis([0 datasetSize(1) minIntensity maxIntensity])
%        set(gca,'xtick',[],'ytick',[])
       b = num2str(i);
       t = [a ' ' b];
        title(t);
        if histo == 1
            xdata1 = get(plot1, 'xdata');
            ydata1 = get(plot1, 'ydata');
            xdata1 = xdata1(:);
            ydata1 = ydata1(:);
            fitResults1 = polyfit(xdata1,ydata1,1);
            slope1 = fitResults1(1,1);
            %slope matrix
            slopeArray = [slopeArray, slope1];
        end
    end
    title(f1,'Mean Intensity vs Relative Pixel Position', 'FontWeight','bold');
    xstr = "Relative Pixel Position of Each Chamber";
    xstr = xstr + newline + "(Left of chamber = 0 px,  right of chamber = "+datasetSize(1) +" px)";
    xlabel(f1, xstr, 'FontWeight','bold');
    ylabel(f1, "Mean Intensity of Each Chamber",'FontWeight', 'bold');
    [filepath,name,~] = fileparts(myFilePath);
    savePath = strcat(filepath,name,'.fig');
    saveas(gcf, savePath);
    if histo == 1
        figure(2)
        histogram(slopeArray);
        title('All Slope')
    end
end
