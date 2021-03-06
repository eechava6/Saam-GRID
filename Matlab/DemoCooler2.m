clc; clear all; close all

syms syms T_0 T_int T_5 th_A A_A K_A th_B A_B K_B th_C A_C K_C M Cp t m_user L_C W_C H_C th_lid rho_A rho_B rho_C Delta_T_ext Delta_T_in
syms th_A_var th_B_var th_C_var L_C_var H_C_var W_C_var th_lid_var 
syms T_0_dist T_5_dist th_A_dist A_A_dist K_A_dist th_B_dist A_B_dist K_B_dist th_C_dist A_C_dist K_C_dist M_dist Cp_dist t_dist m_user_dist L_C_dist W_C_dist H_C_dist th_lid_dist rho_A_dist rho_B_dist rho_C_dist 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Properties Desirability calcuation  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Domaines=[295	310
273	278
0.01	0.03
0.128	0.128
0.01	0.03
0.035	0.035
0.01	0.03
0.128	0.128
20	30
4181.3	4181.3
18000	18000
60	80
0.4	0.6
0.2	0.45
0.2	0.5
0.03	0.04
880	880
28	28
880	880];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Definition of desirabilities %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pr1='Internal temperature';
Pr1_minAC=273;
Pr1_minOk=277.5;
Pr1_aclevel=281.5;
Pr1_maxOK=283;


Pr2_minAC=70e6;
Pr2_minOk=70e6;
Pr2_aclevel=80e6;
Pr2_maxOK=80e6;

Pr3_minAC=0.45;
Pr3_minOk=0.45;
Pr3_aclevel=0.7;
Pr3_maxOK=0.932;

Pr4_minAC=0.35;
Pr4_minOk=0.35;
Pr4_aclevel=0.45;
Pr4_maxOK=0.63;

Pr5_minAC=0.40;
Pr5_minOk=0.40;
Pr5_aclevel=0.50;
Pr5_maxOK=0.58;


Pr6_minAC=5;
Pr6_minOk=14;
Pr6_aclevel=18;
Pr6_maxOK=20;

Pr7_minAC=0.035;
Pr7_minOk=0.045;
Pr7_aclevel=0.05;
Pr7_maxOK=0.052;

% Pr7_minAC=0.0475;
% Pr7_minOk=0.0485;
% Pr7_aclevel=0.05;
% Pr7_maxOK=0.0505;


Desirability_limits=[Pr1_minAC,Pr1_minOk,Pr1_aclevel,Pr1_maxOK;
    Pr2_minAC,Pr2_minOk,Pr2_aclevel,Pr2_maxOK;
    Pr3_minAC,Pr3_minOk,Pr3_aclevel,Pr3_maxOK;
    Pr4_minAC,Pr4_minOk,Pr4_aclevel,Pr4_maxOK;
    Pr5_minAC,Pr5_minOk,Pr5_aclevel,Pr5_maxOK;
    Pr6_minAC,Pr6_minOk,Pr6_aclevel,Pr6_maxOK;
    Pr7_minAC,Pr7_minOk,Pr7_aclevel,Pr7_maxOK];
    
    
 
T_5_mean=273;
T_0_mean=303;
M_mean=25;
Cp_mean=4181.3;
t_mean=18000;

th_A_mean=load('DemoCooler2/InputData_thA.txt');
th_B_mean=load('DemoCooler2/InputData_thB.txt');
th_C_mean=load('DemoCooler2/InputData_thC.txt');
L_C_mean=load('DemoCooler2/InputData_LC.txt');
H_C_mean=load('DemoCooler2/InputData_HC.txt');
W_C_mean=load('DemoCooler2/InputData_WC.txt');
th_lid_mean=load('DemoCooler2/InputData_thl.txt');

rho_A_mean=880;
rho_B_mean=28;
rho_C_mean=880;
K_A_mean=0.128;
K_B_mean=0.035;
K_C_mean=0.128;
m_user_mean=80;

Design_variables_values=[T_0_mean
    T_5_mean
    th_A_mean
    K_A_mean
    th_B_mean
    K_B_mean
    th_C_mean
    K_C_mean
    M_mean
    Cp_mean
    t_mean
    m_user_mean
    L_C_mean
    W_C_mean
    H_C_mean
    th_lid_mean
    rho_A_mean
    rho_B_mean
    rho_C_mean];

Design_variables_full=[Design_variables_values];
[Delta_T_ext,Delta_T_in] = Determine_DeltaT_Cooler(T_0_mean,T_5_mean,th_A_mean,K_A_mean,th_B_mean,K_B_mean,th_C_mean,K_C_mean,L_C_mean,W_C_mean,H_C_mean);

%Raw variables definition
Rel1_raw=T_5_mean + exp((2*H_C_mean*t_mean*(L_C_mean + W_C_mean)*(T_0_mean - T_5_mean))/(Cp_mean*M_mean*(5/(28*(Delta_T_in/(H_C_mean*T_5_mean))^(1/4)) + 5/(28*(Delta_T_ext/(H_C_mean*T_0_mean))^(1/4)) + th_A_mean/K_A_mean + th_B_mean/K_B_mean + th_C_mean/K_C_mean)));
Rel2_raw=(m_user_mean*9.81)*0.5/((2*th_A_mean+2*th_B_mean+2*th_C_mean)*(L_C_mean+2*th_C_mean+2*th_B_mean+2*th_A_mean));
Rel3_raw=L_C_mean+2*th_C_mean+2*th_B_mean+2*th_A_mean;
Rel4_raw=W_C_mean+2*th_C_mean+2*th_B_mean+2*th_A_mean;
Rel5_raw=H_C_mean+th_C_mean+th_B_mean+th_A_mean+th_lid_mean;
Rel6_raw=rho_B_mean*(L_C_mean + 2*th_B_mean + 2*th_C_mean)*(W_C_mean + 2*th_B_mean + 2*th_C_mean)*(H_C_mean + th_B_mean + th_C_mean) - rho_A_mean*(L_C_mean + 2*th_B_mean + 2*th_C_mean)*(W_C_mean + 2*th_B_mean + 2*th_C_mean)*(H_C_mean + th_B_mean + th_C_mean) - rho_C_mean*(H_C_mean*L_C_mean*W_C_mean - (H_C_mean + th_C_mean)*(L_C_mean + 2*th_C_mean)*(W_C_mean + 2*th_C_mean)) + rho_A_mean*(H_C_mean + th_A_mean + th_B_mean + th_C_mean)*(L_C_mean + 2*th_A_mean + 2*th_B_mean + 2*th_C_mean)*(W_C_mean + 2*th_A_mean + 2*th_B_mean + 2*th_C_mean) - rho_B_mean*(H_C_mean + th_C_mean)*(L_C_mean + 2*th_C_mean)*(W_C_mean + 2*th_C_mean);
Rel7_raw=L_C_mean*W_C_mean*H_C_mean;

fprintf('Temperature %6.3f�C,(DESIRABILITY: %6.3f) \n',Rel1_raw-273,zmf(Rel1_raw,[Pr1_minOk, Pr1_aclevel]))
fprintf('Resistance %6.3fPa,(DESIRABILITY: %6.3f) \n',Rel2_raw,zmf(Rel2_raw,[Pr2_minOk, Pr2_aclevel]))
fprintf('External lenght %6.3fm,(DESIRABILITY: %6.3f) \n',Rel3_raw,zmf(Rel3_raw,[Pr3_minOk, Pr3_aclevel]))
fprintf('External width %6.3fm,(DESIRABILITY: %6.3f) \n',Rel4_raw,zmf(Rel4_raw,[Pr4_minOk, Pr4_aclevel]))
fprintf('External height %6.3fm,(DESIRABILITY: %6.3f) \n',Rel5_raw,zmf(Rel5_raw,[Pr5_minOk, Pr5_aclevel]))
fprintf('Total weight %6.3fkg,(DESIRABILITY: %6.3f) \n',Rel6_raw,zmf(Rel6_raw,[Pr6_minOk, Pr6_aclevel]))
fprintf('Internal volumen %6.3fliters,(DESIRABILITY: %6.3f) \n',Rel7_raw*1000,pimf(Rel7_raw,[Pr7_minAC,Pr7_minOk,Pr7_aclevel,Pr7_aclevel]))


[th_A_Equaliser_values,th_A_Equaliser_ranges]=FindEqualiser_values('th_A',Domaines,Desirability_limits,Design_variables_values);
[th_B_Equaliser_values,th_B_Equaliser_ranges]=FindEqualiser_values('th_B',Domaines,Desirability_limits,Design_variables_values);
[th_C_Equaliser_values,th_C_Equaliser_ranges]=FindEqualiser_values('th_C',Domaines,Desirability_limits,Design_variables_values);
[L_C_Equaliser_values,L_C_Equaliser_ranges]=FindEqualiser_values('L_C_',Domaines,Desirability_limits,Design_variables_values);
[W_C_Equaliser_values,W_C_Equaliser_ranges]=FindEqualiser_values('W_C_',Domaines,Desirability_limits,Design_variables_values);
[H_C_Equaliser_values,H_C_Equaliser_ranges]=FindEqualiser_values('H_C_',Domaines,Desirability_limits,Design_variables_values)
[th_lid_Equaliser_values,th_lid_Equaliser_ranges]=FindEqualiser_values('th_l',Domaines,Desirability_limits,Design_variables_values);

dlmwrite('DemoCooler2/th_A_Equaliser_values.txt',th_A_Equaliser_values)
dlmwrite('DemoCooler2/th_A_Equaliser_ranges.txt',th_A_Equaliser_ranges)

dlmwrite('DemoCooler2/th_B_Equaliser_values.txt',th_B_Equaliser_values)
dlmwrite('DemoCooler2/th_B_Equaliser_ranges.txt',th_B_Equaliser_ranges)

dlmwrite('DemoCooler2/th_C_Equaliser_values.txt',th_C_Equaliser_values)
dlmwrite('DemoCooler2/th_C_Equaliser_ranges.txt',th_C_Equaliser_ranges)

dlmwrite('DemoCooler2/L_C_Equaliser_values.txt',L_C_Equaliser_values)
dlmwrite('DemoCooler2/L_C_Equaliser_ranges.txt',L_C_Equaliser_ranges)

dlmwrite('DemoCooler2/W_C_Equaliser_values.txt',W_C_Equaliser_values)
dlmwrite('DemoCooler2/W_C_Equaliser_ranges.txt',W_C_Equaliser_ranges)

dlmwrite('DemoCooler2/H_C_Equaliser_values.txt',H_C_Equaliser_values)
dlmwrite('DemoCooler2/H_C_Equaliser_ranges.txt',H_C_Equaliser_ranges)

dlmwrite('DemoCooler2/th_lid_Equaliser_values.txt',th_lid_Equaliser_values)
dlmwrite('DemoCooler2/th_lid_Equaliser_ranges.txt',th_lid_Equaliser_ranges)

%print('img3\012AggDes_th_lid_it1.png','-dpng')

Rangess=[th_A_Equaliser_ranges(:,2),th_B_Equaliser_ranges(:,2),th_C_Equaliser_ranges(:,2),L_C_Equaliser_ranges(:,2),W_C_Equaliser_ranges(:,2),H_C_Equaliser_ranges(:,2),th_lid_Equaliser_ranges(:,2)];
