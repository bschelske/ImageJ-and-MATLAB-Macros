function mf_grinchscript(petdetred, petdetgreen, intden, chambers, log, histo, p)
    %Import files declared by app    
    pdr_opts = detectImportOptions(petdetred);
    pdr = readmatrix(petdetred, pd_opts); %petdetective matrix
    pdg_opts = detectImportOptions(petdetgreen);
    pdg = readmatrix(petdetgreen, pd_opts); %petdetective matrix
    id_opts = detectImportOptions(intden);
    id = readmatrix(intden, id_opts); %intden matrix
    sz = size(id);
    Max = max(id,[],'all'); %max value of intden
    min_id = id;
    min_id(:,1)=[]; %min value of intden such that 0-time end isnt considered
    Min = min(min_id,[],'all');
    clear figure(1)
    clear figure(2)
    figure(1)
    f1 = tiledlayout(8,20);
    %establish empty matrices
    cell_slope = [];
    all_slope = [];
    for i=1:chambers
           nexttile;
        %petdet to green cell chambers
            if pd(i,4) == 0
            color = ('k.');
            else 
                color = ('g.');
            end
        %log of data if declared -> multiplot
        if log == 1
            y_log = log10(id(:,i+1));
            plot1 = plot(id(:,1), y_log, color);
        end
    %mutliplot
        if log == 0
            plot1 = plot(id(:,1), id(:,i+1), color);
        end
       %plot on x axis from 0 to time max, y from min id to max id
       axis([0 sz(1) Min Max]) 
       set(gca,'xtick',[],'ytick',[]); %removes axis labels (gca get current axis)
       b = num2str(i); %plot titles by number
       title(b);
        if histo == 1
            xdata1 = get(plot1, 'xdata');
            ydata1 = get(plot1, 'ydata');
            xdata1 = xdata1(:);
            ydata1 = ydata1(:);
            fitResults1 = polyfit(xdata1,ydata1,1);
            slope1 = fitResults1(1,1);
            all_slope = [all_slope, slope1];
            %slope matrix
                if pd(i,4) == 1
                    cell_slope = [cell_slope, slope1];
                end
        end
    end
    tstr = "Timelapse results for " +chambers + " Chambers"; 
    tstr = tstr + newline + "(Fluorescence vs Time)";
    title(f1,tstr, 'FontWeight','bold');
    xstr = "Time" +newline + "(from 0 to "+sz(1)+" min)";
    xlabel(f1, xstr, 'FontWeight','bold');
    ylabel(f1, "Flourescence Intensity (arb. unit)",'FontWeight', 'bold');
    if histo == 1
        figure(2)
       f2= tiledlayout(1,2);
        nexttile;
        histogram(all_slope);
        title('All Slope')
        nexttile;
        histogram(cell_slope);
        title('Cell Slope')
    xstr = "Slope (Fluorescence vs Time)";
    xlabel(f2, xstr, 'FontWeight','bold');
    ylabel(f2, "Quantity of Chambers",'FontWeight', 'bold');
    end
end

