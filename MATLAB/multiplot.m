's'
opts = detectImportOptions('C:\Users\bensc\Desktop\Research\MATLAB\Grinch App\20220629_10.52_profile.csv');
% preview("20220607_16.42_IntDen.csv", opts)
id = readmatrix("C:\Users\bensc\Desktop\Research\MATLAB\Grinch App\20220629_10.52_profile.csv", opts);
chambers = 160;
a = 'Chamber';
tiledlayout(8,7);
Max = max(id,[],'all');
sz = size(id);
min_id = id;
min_id(:,1)=[];
Min = min(min_id,[],'all');
figure(1)
for i=1:(sz(1,2)-1)
  nexttile
  plot(id(:,1), id(:,i+1), 'r.')
  axis([0 sz(1) Min Max])
  set(gca,'xtick',[],'ytick',[])
  b = num2str(i);
    t = [a ' ' b];
    title(t);
         
end


