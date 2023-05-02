close all
clc
tic
clear

% %% %%%%%%%%%%%%%%%%%%%%%%%%%原始数据文件名和地址输入%%%%%%%%%%%%%%%%%%%%%%%%%
Variable_name='变量名CH8';%Onenet里面的变量名
Address_original_data=strcat('D:\数据\产品(8通道电导电极测试)447665\设备(电导率远程监测)852782109\',Variable_name,'\');%原始数据存储位置
Dis = dir(Address_original_data); 
DirCell=struct2cell(Dis);

filename0 = sort_nat(DirCell(1,3:end));%带后缀的CSV文件名字
filename0=filename0';

time_data=[];
for i=1:size(filename0,1)
    
    filename=cell2mat(filename0(i));
    fileadress=strcat(Address_original_data,filename);
    NUM0=readtable(fileadress);%读取excell数据
    time0=table2array(NUM0(:,1));%读取时间列
    data0=table2array(NUM0(:,2));%读取数据列

    time_data0=[];
     for j=1:size(data0,1)%循环文件个数
        data3=str2double(cell2mat(data0(j,:)));%将cell转化为double
        time3=cell2mat(time0(j,:));%将cell转化为str

        year=str2double(time3(1:4));%取时间的年
        month=str2double(time3(6:7));%取时间的月
        day=str2double(time3(9:10));%取时间的日
        hour=str2double(time3(12:13));%取时间的时
        mine=str2double(time3(15:16));%取时间的分
        second=str2double(time3(18:end));%取时间的秒
        if i==1&&j==1
        n0=datenum(year,month,day,hour,mine,second);%计算相对于0年1月0日的时间差,单位是天数
        end
        n=datenum(year,month,day,hour,mine,second)-n0;%计算相对于n0的时间差
        time_data1=[n*24*60*60,data3];
        time_data0=[time_data0;time_data1];
     end
    time_data=[time_data;time_data0];
    
end
N=2409;
X=time_data(N:end,1)-time_data(N,1);
Y=time_data(N:end,2);
X_Y=[X,Y];
figure(1)
plot(X,Y)




















