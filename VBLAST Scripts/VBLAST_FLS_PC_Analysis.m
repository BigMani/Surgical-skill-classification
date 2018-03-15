% Calculate VBLAST and FLS pattern cutting performance scores
VBLAST_N = [116.6;173.4;139.2;116;135.4;135.6;179.4];
VBLAST_E = [175.6;165.8;180.8;146.2;170;161.6;198.6;190.4;173];

FLS_N = [166.6;184.1;173.8;122.6;127.6;124;158.3];
FLS_E = [186.4;222;198.9;167.4;184.6;150.6;181.2;235.6];

%VBLAST
[p,~] = ranksum(VBLAST_N,VBLAST_E);
p = floor(p*1000)/1000;
pp = strcat('p = ',num2str(p));
group = [repmat({'Novice'}, 7, 1); repmat({'Expert'}, 9, 1)];

boxplot([VBLAST_N;VBLAST_E], group)
ylim([110 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',10,'FontWeight','bold');
ylabel('VBLAST Pattern Cutting Score','FontSize',12,'FontWeight','bold')

%FLS
[p,~] = ranksum(FLS_N,FLS_E);
p = floor(p*1000)/1000;
pp = strcat('p = ',num2str(p));
group = [repmat({'Novice'}, 7, 1); repmat({'Expert'}, 8, 1)];
figure;
boxplot([FLS_N;FLS_E], group)
ylim([110 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',10,'FontWeight','bold');
ylabel('FLS Pattern Cutting Score','FontSize',12,'FontWeight','bold')