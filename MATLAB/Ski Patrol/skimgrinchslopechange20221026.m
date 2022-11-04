function skimgrinchslopechange20221026(petdetcsvpath, intdenpath, nChambers, isLog, isHisto, numChanges, isMultiplot, isCellplot)
% petdetcsvpath, intdenpath, nChambers, isLog, isHisto, isMultiplot,
% isCellplot all declared from grinch app
%petdet and intden csvs are from imageJ macros
timenow = datetime('now');
disp('________skimgrinchslopechange20221026________');
disp(timenow);
tic
petDetOptions = detectImportOptions(petdetcsvpath);
petDetMatrix = readmatrix(petdetcsvpath, petDetOptions); %(col 1 1:160) (col 2 1:160) (col 3 max intensities) (col 4 cell present == 1)
intDenOptions = detectImportOptions(intdenpath);
intDenMatrix = readmatrix(intdenpath, intDenOptions); %rows = time,  cols = chamber integrated density, COL 2 = CHAMBER 1
intDenMatrix(:,1) = []; %Removes useless col 1
intDenSize = size(intDenMatrix);
cellSlopeArray = [];
allSlopeArray = [];
timeArray = 1:1:intDenSize(1,1); %matrix from 1 to time limit incrementing by 1. gives row of length time
timeArray = timeArray.';
slopes = nan(nChambers, numChanges+1);
numChanges = numChanges;
%RSQ
fitOrder = 1;
sub_rsq_array = [];
rsq_array = [];
I = [];
petdet_glory = [];
rsq_percent_change = [];
%RSQ

clear figure(1);
clear figure(2);
clear figure(3);

if isMultiplot == 1
    multiplot;
elseif isCellplot == 1
    cellplot;
end


    function cellplot
        cellArray = intDenMatrix;
        blankArray = intDenMatrix;
        backroundSubtractedArray = intDenMatrix;
        cellTitleArray = [];
        color = ('g.');
        j = 1; %it just works
        for nChamber=1:nChambers
            if petDetMatrix(nChamber,4) == 1 %if cell, record chamber id number
                cellTitleArray(end+1) = nChamber;
                blankArray(:,j) = []; %Need to collect data for empty chambers for background subtraction
                j = j+1;

            else
                cellArray(:,j+1) = []; %remove intensity column if no cell
            end %if loop
        end %for loop

        %Background Subtraction
        averageBackgroundArray = mean(blankArray, 2);
        backgroundArraySize = size(averageBackgroundArray);
        intDenCellArraySize =size(cellArray);
        for n=1:backgroundArraySize(1,1)
            for itteration=2:intDenCellArraySize(1,2)
                backroundSubtractedArray(n,itteration) = cellArray(n,itteration) - averageBackgroundArray(n,1);
            end
        end %background subtraction

        f1 = tiledlayout('flow');
        for nChamber=2:intDenCellArraySize(1,2) %nightmare
            nexttile;
            if isLog == 1
                y_log = log10(backroundSubtractedArray(:,nChamber)); %convert intensity to log
                plot1 = plot(backroundSubtractedArray(:,1), y_log, color); %plot log
            else
                plot1 = plot(backroundSubtractedArray(:,1), backroundSubtractedArray(:,nChamber), color);
            end
            axis([0 intDenSize(1) minIntensity maxIntensity])
            set(gca,'xtick',[],'ytick',[]); %removes axis labels (gca get current axis)
            title(num2str(cellTitleArray(nChamber-1)));
        end
    end %func cellplot


    function multiplot
        tiledlayout(8,20);
        backgroundArray = intDenMatrix; %Array containing blanks
        j = 1; %shrinking matrix j magic
        for nChamber=1:nChambers
            if petDetMatrix(nChamber,4) == 1 %petdetective
                backgroundArray(:,j) = []; %Remove data from array describing cells
            else
                j = j+1;
            end
        end %Get empty chamber value matrix

        %Background Subtraction
        averageBackgroundArray = mean(backgroundArray, 2);
        backroundSubtractedArray = intDenMatrix - averageBackgroundArray;
        %background subtraction

        maxIntensity = max(intDenMatrix, [], 'all');
        %         maxSubIntensity = max(backroundSubtractedArray,[],'all');
        minSubIntensity = min(backroundSubtractedArray,[],'all');
        %         figure(3);
        %         plot(timeArray, averageBackgroundArray, 'r.');
        figure(1);
tiledlayout("flow");
        for nChamber=1:nChambers
            nexttile;
            sub_nChamberIntensities = backroundSubtractedArray(:,nChamber);
            
            [TF, S1, S2] = ischange(sub_nChamberIntensities, "linear", 'MaxNumChanges',numChanges);
            TF_size = size(TF);
            TF_changes = sum(TF);
            slopeCoordinateArray = zeros((TF_changes + 1),5); %zero preallocation need to do for each chamber too ???
            %slopeCoordinateArray:
            % A(row, 1) = x1  A(row, 2) = y1
            % A(row, 3) = x2  A(row, 4) = y2
            % A(row, 5) = slope
            %Include first data point as first point of slope TF[1,1]
            %should be 0 I think...
            slopeCoordinateArray(1,1) = timeArray(1, 1);
            slopeCoordinateArray(1,2) = sub_nChamberIntensities(1, 1);
            TF_magic = 1; %j magic
            for TF_index=2:TF_size(1,1) %Begin at 2 because first value is added above
                if TF(TF_index,1) == 1
                    slopeCoordinateArray(TF_magic,3) = timeArray(TF_index, 1); %X2
                    slopeCoordinateArray(TF_magic,4) = sub_nChamberIntensities(TF_index, 1); %Y2
                    slopeCoordinateArray(TF_magic,5) = (slopeCoordinateArray(TF_magic,4) - slopeCoordinateArray(TF_magic,2)) / (slopeCoordinateArray(TF_magic,3) - slopeCoordinateArray(TF_magic,1)); %slope
                    TF_magic = TF_magic + 1;
                    slopeCoordinateArray(TF_magic,1) = timeArray(TF_index, 1); %X1
                    slopeCoordinateArray(TF_magic,2) = sub_nChamberIntensities(TF_index, 1);%Y1
                end % if TF coordinate array determination
            end % for TF coordinate array determination
            slopeCoordinateArray(TF_magic,3) = timeArray(TF_size(1,1), 1);
            slopeCoordinateArray(TF_magic,4) = sub_nChamberIntensities(TF_size(1,1), 1);
            slopeCoordinateArray(TF_magic,5) = (slopeCoordinateArray(TF_magic,4) - slopeCoordinateArray(TF_magic,2)) / (slopeCoordinateArray(TF_magic,3) - slopeCoordinateArray(TF_magic,1));
            for value = 1:size(slopeCoordinateArray, 1)
                slopes(nChamber, value) = slopeCoordinateArray(value, 5);
            end


%             nChamberIntensities = intDenMatrix(:,nChamber);
            segline = S1.*(timeArray) + S2;
            %Background Subtracted RSQ
            sub_coefficients = polyfit(timeArray,sub_nChamberIntensities,fitOrder);
            sub_nChamberFit = polyval(sub_coefficients , timeArray);
            sub_yresid = sub_nChamberIntensities - sub_nChamberFit;
            sub_ssresid = sum(sub_yresid.^2);
            sub_sstotal = (length(sub_nChamberIntensities))*var(sub_nChamberIntensities);
            sub_rsq_value = 1-sub_ssresid/sub_sstotal;
            sub_rsq_array = [sub_rsq_array;sub_rsq_value];
            if petDetMatrix(nChamber,4) == 0 %petdetective
                color = ('k.'); %black is k: no cell
            else
                color = ('g.'); %green is g: cell present
            end %petdective
        
            if isLog == 1
                %                 y_log = log10(backroundSubtractedArray(:,nChamber)); %convert intensity to log
                %                 plot1 = plot(backroundSubtractedArray(:,1), y_log, color); %plot log
            else
                plot(timeArray, segline, 'r-', 'LineWidth', 1);
                hold on
                color = 'k.'; %color testing
                for value = 1 : size(slopeCoordinateArray, 1)
                    plot(slopeCoordinateArray(value,1),slopeCoordinateArray(value,2), color,'MarkerSize',20)
                end
                plot(slopeCoordinateArray(value,3),slopeCoordinateArray(value,4),color,'MarkerSize',20)
                 plot1 = plot(timeArray, backroundSubtractedArray(:,nChamber), color, 'MarkerSize' , 5);
                %                 plot(timeArray, nChamberFit, 'r-', 'LineWidth', 1);
%                 plot(timeArray, sub_nChamberFit, 'r-', 'LineWidth', 1);
                %                 plot(timeArray, intDenMatrix(:,nChamber), 'b.');
%                 set(gca,'xtick',[],'ytick',[]); %removes axis labels (gca: get current axis) 160 axis labels is bad
                set(gcf,'color','w');
                                axis([0 intDenSize(1) (minSubIntensity) (maxIntensity)]) %x axis 0 to time max, y from min intensity to max intensity
                title(nChamber);
                hold off
            
            end %end log
        
            if isHisto == 1
                %                 xdata1 = get(plot1, 'xdata');
                %                 ydata1 = get(plot1, 'ydata');
                %                 xdata1 = xdata1(:);
                %                 ydata1 = ydata1(:);
                %                 fitResults1 = polyfit(xdata1,ydata1,1);
                %                 slope1 = fitResults1(1,1);
                %                 allSlopeArray = [allSlopeArray, slope1];
                %                 if petDetMatrix(nChamber,4) == 1 %slope matrix from cells only
                %     				cellSlopeArray = [cellSlopeArray, slope1];
                %                 end
            end %is histo
            I = [I;nChamber];
            petdet_glory = [petdet_glory; petDetMatrix(nChamber,4)];            
        end %nchambers loop

            GloriousTable = table(I, petdet_glory, slopes, sub_rsq_array, 'VariableNames', {'Chamber','Cell in Chamber?','Slopes', 'RSQ'});

% T = table(I, rsq_array, sub_rsq_array, rsq_percent_change, 'VariableNames',{'Chamber','RSQ w/out Background Subtraction', 'RSQ w Background Subtraction', '% Change in RSQ'});
tableName = datetime('now','Format','yyyyMMdd');
[filepath,name,ext] =  fileparts(intdenpath);
tableName = string(tableName) + '_' + name + '_slopechange.csv';
writetable(GloriousTable, tableName)
GloriousTable
disp("Table saved as: "+ which(tableName))
%         if isHisto == 1
%             f2 = figure(2);
%             histogram(cellSlopeArray);
%             title('Cell Slope')
%             xstr = "Slope (Fluorescence vs Time)";
%             xlabel(f2, xstr, 'FontWeight','bold');
%             ylabel(f2, "Quantity of Chambers",'FontWeight', 'bold');
%         end
end %func multiplot
toc
end %grinchscript
