opts = detectImportOptions("20220607_16.42_IntDen.csv");
% preview("20220607_16.42_IntDen.csv", opts)
id = readmatrix("20220607_16.42_IntDen.csv", opts);
chamber = 146;
a = 'Chamber';
tiledlayout('flow');
clear figure
figure(1)
for  i =chamber
  nexttile
    %     if mod(i,12)==0
%         figure(i/12)
%     end
    plot(id(:,1), id(:,i+1), 'r.')
    b = num2str(i);
    t = [a ' ' b];
    title(t);
         
end

