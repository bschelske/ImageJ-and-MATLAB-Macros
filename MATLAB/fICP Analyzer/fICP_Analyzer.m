function fICP_Analyzer(filepath,filepath_2, histo)
    %Multiplot for varying lentgh line profile gradient from circle pro 2
    % opts = detectImportOptions('C:\Users\bensc\Desktop\Research\MATLAB\Grinch App\20220629_10.52_profile.csv');
    % id = readmatrix("C:\Users\bensc\Desktop\Research\MATLAB\Grinch App\20220629_10.52_profile.csv", opts);
    opts = detectImportOptions(filepath);
    dataset = readmatrix(filepath, opts);
    opts_2 = detectImportOptions(filepath_2);
    dataset_2 = readmatrix(filepath_2, opts_2);
    a = 'Chamber';
    f1 = tiledlayout(8,5);
    CombinedData = cat(2, dataset, dataset_2);
%     Max = max(CombinedData,[],'all');
    Max = max(dataset_2,[],'all');
    sz = size(dataset);
    dataset_min = CombinedData;
    dataset_min(:,1)=[];
    all_slope = zeros(1,(sz(1,2)-1));
    Min = min(dataset_min,[],'all');
    figure(1)
    for i=1:(sz(1,2)-1)
      nexttile
      plot1 = plot(dataset(:,1), dataset(:,i+1), 'g.');
      hold on
      plot1 = plot(dataset_2(:,1), dataset_2(:,i+1), 'r.');
      hold off
      axis([0 sz(1) Min Max])
      set(gca,'xtick',[],'ytick',[])
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
            all_slope = [all_slope, slope1];
        end
    end
    title(f1,'Mean Intensity vs Relative Pixel Position', 'FontWeight','bold');
    xstr = "Relative Pixel Position of Each Chamber";
    xstr = xstr + newline + "(Left of chamber = 0 px,  right of chamber = "+sz(1) +" px)";
    xlabel(f1, xstr, 'FontWeight','bold');
    ylabel(f1, "Mean Intensity of Each Chamber",'FontWeight', 'bold');
    if histo == 1
        figure(2)
        histogram(all_slope);
        title('All Slope')
    end
end
