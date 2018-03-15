% CUSUM Analysis
clear all;

close all;

h0=-2.09;
h1=3.71;



s= 0.07;
s1=1-0.07;

MS5=[54.8
45.7
56.0
60.4
47.3
66.3
65.2
71.0
64.9
57.7
59.3
59.1
57.3
65.5
62.7
68.8
59.2
62.9
59.8
63.6
63.2
68.7
70.5
64.8
64.8
66.8
71.9
66.5
66.6
63.1
67.5
71.6
74.6
68.1
64.5
77.6
76.9
77.2
74.8
70.6
76.0
79.6
78.4
78.3
77.9
79.3
79.0
77.9
84.9
80.5
76.7
72.0
60.2
67.3
68.3
64.7
69.7
72.6
78.2
65.8
66.4
70.8
67.1
66.5
65.9
73.0
68.3
64.5
62.3
59.1
62.4
61.2
61.3
65.6
61.4
67.1
65.5
57.2
62.2
69.9
68.2
76.7
68.0
69.5
67.3
68.3
74.0
71.7
70.5
72.6
73.4
76.8
75.1
78.4
78.1
79.1
78.4
77.7
71.8
78.6
75.8
76.6
80.8
76.9
77.2
73.0
78.2
75.1
75.7
78.0
70.3
71.3
72.5
71.0
71.5
72.7
68.5
67.5
67.6
70.6
63.7
65.9
71.2
64.1
70.7
69.2
73.4
62.9
69.8
70.7
62.1
68.1
74.3
77.6
75.2
72.4
79.5
78.6
78.1
74.0
73.7
76.0
73.4
71.6
73.0
70.0
76.0
71.0
73.8
69.3];

MS17=[38.8
32.4
26.9
14.3
64.5
44.1
31.4
64.4
39.2
36.0
66.9
62.5
51.2
40.8
60.2
56.1
74.1
66.4
67.7
69.5
70.5
59.5
63.1
71.8
79.5
79.2
66.3
73.7
73.5
66.0
77.1
76.6
71.8
67.4
78.0
72.7
83.3
79.9
78.5
72.7
71.4
72.3
70.8
75.2
71.1
53.0
66.9
78.7
64.2
70.7
65.2
72.2
75.3
65.1
66.6
80.6
79.6
74.0
77.7
73.9
72.7
74.4
77.8
76.0
77.5
75.5
80.0
78.0
75.2
73.9
76.3
78.4
82.0
75.7
69.1
75.5
74.6
78.9
78.2
74.5
79.0
75.4
80.3
84.5
84.6
77.6
81.7
82.2
84.9
80.5
80.2
81.7
81.8
85.7
83.1
84.4
82.8
81.3
84.1
79.0
83.9
82.6
87.3
87.3
88.1
89.8
87.0
89.1
84.9
87.5
85.1
84.2
88.2
87.2
85.2
89.1
81.7
84.5
85.2
81.8
81.3
81.6
83.0
84.6
78.8
81.8
81.3
78.0
80.8
85.2
86.5
88.8
87.6
87.0
84.9
88.0
86.8
88.2
87.2
80.2
85.5
83.0
82.0
85.1
83.3
85.1
82.5
85.1
79.6
79.6];

MS19=[0.0
33.2
39.9
41.4
43.5
51.6
40.7
61.4
54.8
38.9
40.2
35.5
34.3
48.4
42.5
48.2
47.2
47.0
47.6
56.4
55.6
54.0
48.6
65.7
34.5
51.5
51.1
48.5
47.7
64.7
65.5
58.7
57.7
65.5
62.5
63.6
60.7
68.0
60.7
64.7
58.6
60.0
55.6
57.8
62.9
60.0
69.9
53.4
60.8
61.4
60.9
63.6
64.5
73.5
73.6
67.0
71.5
78.7
74.1
66.9
71.1
69.4
67.5
75.7
79.1
71.7
71.4
67.7
73.5
73.5
67.5
66.9
76.0
83.9
53.1
77.7
68.3
65.3
74.8
80.6
72.3
80.9
73.1
80.6
75.4
77.2
74.8
72.4
81.7
71.1
73.4
77.8
78.4
75.9
72.4
81.1
77.6
77.5
77.3
77.3
82.7
80.4
84.7
81.7
85.5
84.4
82.6
79.6
81.1
76.4
80.3
80.8
82.3
83.6
79.3
79.6
79.4
75.9
84.6
82.9
73.9
83.7
82.2
81.4
86.4
88.1
84.8
83.1
83.0
80.9
87.3
84.7
82.7
86.7
86.1
85.3
86.1
84.0
87.3
82.6
84.0
83.1
81.1
79.5
82.3
76.5
75.8
86.9
86.6
86.6];

MS18=[36.4
58.8
41.5
58.5
66.8
63.5
59.5
66.7
68.7
70.5
58.1
76.2
72.1
65.7
72.5
76.2
75.9
66.5
69.8
70.2
66.1
69.9
70.6
65.3
61.4
65.4
66.1
69.9
65.6
69.4
69.5
70.4
64.0
69.2
73.5
67.6
63.4
76.3
69.9
75.2
73.9
74.7
75.2
69.5
71.2
74.1
74.7
69.9
73.8
72.7
73.8
67.1
74.9
67.8
72.7
69.1
65.9
72.6
71.6
75.0
73.0
78.1
67.6
69.0
71.1
75.7
70.4
70.9
74.8
70.5
55.8
72.6
75.6
63.0
70.7
83.8
76.5
73.4
71.8
73.0
72.6
67.3
76.7
72.6
68.0
71.5
72.5
78.9
71.9
75.9
69.1
75.7
80.1
78.8
73.5
70.1
73.1
78.6
75.8
77.3
78.9
78.8
80.8
78.8
72.4
76.2
80.0
74.7
78.1
76.4
76.8
81.7
73.3
73.0
77.8
71.7
75.5
76.8
73.9
75.8
77.3
75.9
77.5
75.0
69.3
77.3
78.7
76.8
70.3
76.1
75.3
79.0
79.5
81.6
77.1
75.8
78.3
76.3
73.8
72.7
77.9
73.8
82.2
79.2
80.3
81.5
79.8
77.5
80.2
84.9];

MS20=[63.6
53.2
53.7
44.4
59.9
75.2
79.2
74.0
76.3
74.2
75.2
77.8
78.3
74.7
76.5
83.6
79.5
77.3
78.4
78.4
74.0
75.8
66.6
70.4
82.7
82.1
82.8
79.9
75.3
80.7
78.6
70.7
81.1
81.8
86.0
84.6
76.8
84.0
85.1
86.3
79.7
78.0
82.3
82.3
81.8
82.3
85.2
85.4
81.1
86.4
77.4
82.5
84.9
81.3
79.6
83.7
83.4
84.5
79.5
81.5
81.0
78.6
82.0
83.3
84.3
82.5
85.4
80.2
83.4
84.4
81.5
80.3
86.4
83.8
84.4
89.5
88.0
86.8
87.3
86.8
81.9
82.2
79.3
84.6
80.8
85.4
79.4
82.4
85.5
85.3
81.6
80.9
84.9
75.8
61.8
83.9
83.9
84.8
86.1
85.9
83.6
85.3
88.4
83.9
85.6
86.5
85.7
87.7
88.7
86.8
83.0
82.0
84.5
83.5
81.8
86.7
82.9
83.7
86.3
83.2
83.8
86.6
86.5
84.1
86.7
82.3
87.4
87.3
87.9
84.2
85.8
85.4
87.2
85.2
87.4
88.5
86.6
88.7
86.5
89.0
85.2
86.8
85.5
89.1
88.8
87.2
87.4
85.3
87.4
86.3];

MS34=[51.2
53.6
52.0
52.7
79.5
69.2
65.2
68.1
79.5
79.4
76.1
76.9
74.6
74.9
76.7
83.1
83.2
83.9
84.3
82.2
74.4
71.9
78.3
80.5
75.7
77.7
75.6
80.0
80.1
73.5
77.7
81.6
85.2
68.8
80.5
76.8
86.3
79.6
83.3
83.5
57.8
82.0
87.3
87.9
81.0
84.9
84.0
80.6
55.5
72.3
75.0
83.4
78.8
74.6
83.1
82.6
82.7
83.3
80.7
84.4
71.7
69.2
81.8
85.0
74.3
84.6
84.4
83.7
75.3
87.3
80.8
83.5
89.0
84.1
88.7
82.6
78.2
88.6
87.9
85.3
87.8
83.8
89.4
79.9
84.0
86.3
89.2
87.3
84.0
84.9
61.2
83.3
82.9
79.4
76.4
82.1
84.5
86.5
85.8
82.3
70.8
79.6
76.6
66.4
82.0
77.3
80.6
81.4
69.9
82.6
83.0
88.8
85.8
87.8
77.8
87.5
86.9
88.7
87.3
85.0
81.5
82.1
85.6
82.6
83.7
85.0
86.5
82.8
78.7
84.3
85.8
79.2
89.1
88.0
89.8
87.8
86.4
84.9
88.2
87.3
83.5
83.4
83.9
84.8
84.0
89.9
82.3
86.0
89.0
88.9];

MS39=[34.4
47.9
35.1
56.2
21.1
47.1
45.9
65.7
70.3
57.5
57.8
66.3
69.5
71.8
76.0
73.5
66.7
78.2
76.0
80.1
74.4
75.4
74.5
64.0
67.5
64.7
76.5
78.4
84.2
77.2
74.2
76.3
74.5
76.2
75.9
79.8
70.5
72.6
81.0
78.7
73.2
73.4
77.2
82.4
82.0
82.1
72.2
69.0
72.2
82.8
78.5
82.8
68.7
84.9
83.7
68.6
84.7
76.4
81.8
86.3
79.7
72.3
81.2
80.3
73.5
86.9
78.6
88.9
84.2
86.4
78.2
80.8
84.5
83.1
83.8
81.7
66.3
83.8
86.9
84.8
77.0
89.1
78.2
90.1
84.6
87.0
79.8
88.9
86.9
84.3
88.3
81.9
82.7
85.8
84.5
82.2
82.1
81.0
84.0
86.8
84.1
79.5
82.4
83.3
82.6
83.4
79.3
83.5
80.2
73.8
79.8
78.4
84.7
82.2
81.7
84.8
81.4
81.9
75.6
84.8
79.9
79.6
87.3
80.1
82.5
81.2
83.7
80.3
73.7
85.8
72.4
78.3
75.2
80.4
83.6
87.5
88.3
64.7
82.6
87.1
82.8
81.5
65.0
73.1
83.9
81.2
75.9
85.7
85.5
86.0];

S43=[32.3
52.7
56.1
56.4
47.1
60.7
50.1
54.3
65.2
68.2
59.5
62.3
66.2
60.0
53.1
68.9
65.6
67.7
74.1
71.8
64.2
74.1
66.8
70.9
67.4
75.2
68.3
74.2
73.2
70.3
68.6
75.4
78.1
76.8
75.0
75.0
80.3
84.3
77.4
79.0
81.1
82.4
80.7
76.6
82.0
76.6
85.6
77.5
78.7
80.5
75.2
83.1
84.2
85.9
84.9
86.6
90.6
87.1
80.7
86.8
86.2
84.4
85.8
82.0
83.9
85.5
83.2
83.0
79.7
78.4
80.5
81.6
85.8
83.5
84.0
84.4
85.0
84.4
85.0
86.3
84.9
77.4
81.0
78.0
81.7
86.0
83.1
82.9
83.3
81.7
79.5
80.2
78.3
82.6
81.1
83.6
78.8
81.7
83.2
84.5
81.4
77.5
81.5
81.0
83.2
83.8
84.8
84.3
84.9
78.5
81.2
86.1
84.9
87.9
88.2
87.7
87.9
86.9
87.7
88.0
82.2
85.3
87.5
79.3
86.6
83.6
83.7
84.2
79.9
82.3
84.2
83.3
85.1
88.8
86.9
87.1
85.0
86.8
87.8
88.0
78.0
82.0
84.2
80.3
81.5
83.5
85.4
83.9
79.8
83.3];

[t1,sc1,bs1,cs1]=CUSUM(MS5,72,s,s1); %72
[t2,sc2,bs2,cs2]=CUSUM(MS17,72,s,s1); %72
[t3,sc3,bs3,cs3]=CUSUM(MS18,72,s,s1); %72
[t4,sc4,bs4,cs4]=CUSUM(MS19,72,s,s1); %72
[t5,sc5,bs5,cs5]=CUSUM(MS20,72,s,s1); %72
[t6,sc6,bs6,cs6]=CUSUM(MS34,72,s,s1); %72
[t7,sc7,bs7,cs7]=CUSUM(MS39,72,s,s1); %72

%plot the learning curve 

UL(1:length(t1))=h1;
LL(1:length(t1))=h0;

plot(t1,cs1,t1,cs2,t1,cs3,t1,cs4,t1,cs5,t1,cs6,t1,cs7);
legend('MS5','MS17', 'MS18', 'MS19','MS20','MS34', 'MS39');
hold on;
plot(t1,UL);
plot(t1,LL);







