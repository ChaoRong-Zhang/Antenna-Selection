close all;
clear all;
format long;

Ns=4; %��������
Nr=16;%��������
Lr=4;
%SNROfdB=30;%dB
%SNR= 10^(SNROfdB/10); %dBת��SNR������ȣ���λΪdB)=10 lg��S/N)����һ�£�S/N=10^(SNR/10��
simulation=1000; %�ظ��������
 

capacityOfFastAver=[];
capacityOfRandomAver=[];
capacityOfOptimalAver=[];
capacityOfGorokohovAver=[];
capacityOfNBSAver=[];

for SNROfdB=0:20
    SNR= 10^(SNROfdB/10); %dBת��SNR������ȣ���λΪdB)=10 lg��S/N)����һ�£�S/N=10^(SNR/10��
    capacityOfFastSum=0;
    capacityOfRandomSum=0;
    capacityOfOptimalSum=0;
    capacityOfGorokohovSum=0;
    capacityOfNBSSum=0;
    
    antennaSubset=nchoosek([1:Nr],Lr);%���п��ܵ������Ӽ�
    
    for sim=1:simulation
        H=sqrt(1/2)*(randn(Nr,Ns)+1j*randn(Nr,Ns));%�����ŵ�
        fullAntenna=[1:Nr];%���������߼���
        
        %% fastAntennaSelected
        capacityOfFastSelected=fastSelected(Nr,Ns,Lr,SNR,H,fullAntenna); %ѡ��Lr�����ߺ���ŵ�����
        capacityOfFastSum=capacityOfFastSum+capacityOfFastSelected;%�ŵ������ۼ�ֵ
        
        
        %% randomAntennaSelected ��
        capacityOfRandomSelected=randomSelected(Nr,Ns,Lr,SNR,H,fullAntenna); %ѡ��Lr�����ߺ���ŵ�����
        capacityOfRandomSum=capacityOfRandomSum+capacityOfRandomSelected;%�ŵ������ۼ�ֵ
        
        
        %% optimalAntennaSelected
        capacityOfOptimalSelected=optimalSelected(Nr,Ns,Lr,SNR,H,antennaSubset);%ѡ��Lr�����ߺ���ŵ�����
        capacityOfOptimalSum=capacityOfOptimalSum+capacityOfOptimalSelected;%�ŵ������ۼ�ֵ
        
        %% gorokohovAntennaSelected
        capacityOfGorokohovSelected=gorokohovSelected(Nr,Ns,Lr,SNR,H,fullAntenna);%ѡ��Lr�����ߺ���ŵ�����
        capacityOfGorokohovSum=capacityOfGorokohovSum+capacityOfGorokohovSelected;%�ŵ������ۼ�ֵ
        
        %%NBSAntennnaSelected
        capacityOfNBSSelected=NBSAntennaSelected(Nr,Ns,Lr,SNR,H,fullAntenna);%ѡ��Lr�����ߺ���ŵ�����
        capacityOfNBSSum=capacityOfNBSSum+capacityOfNBSSelected;%�ŵ������ۼ�ֵ
        
        
    end
    capacityOfFastAver=[capacityOfFastAver,capacityOfFastSum/simulation];
    capacityOfRandomAver=[capacityOfRandomAver,capacityOfRandomSum/simulation];
    capacityOfOptimalAver=[capacityOfOptimalAver,capacityOfOptimalSum/simulation];
    capacityOfGorokohovAver=[capacityOfGorokohovAver,capacityOfGorokohovSum/simulation];
    capacityOfNBSAver=[capacityOfNBSAver,capacityOfNBSSum/simulation];
    
    
end
X=[0:20];
plot(X,capacityOfOptimalAver,'c',X,capacityOfFastAver,'k-o',X,capacityOfGorokohovAver,'b-+',X,capacityOfRandomAver,'r',X,capacityOfNBSAver,'b');
legend('optimalSelected','fastSelected','gorokohovSelected','randomSelected','NBSSelected');
xlabel('SNROfdB');
ylabel('capacity(bit/s/Hz)');
grid on;
