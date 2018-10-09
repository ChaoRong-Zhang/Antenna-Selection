close all;
clear all;
format long; 

Ns=4; %��������
Nr=16;%��������
SNROfdB=6;%dB
SNR= 10^(SNROfdB/10); %dBת��SNR������ȣ���λΪdB)=10 lg��S/N)����һ�£�S/N=10^(SNR/10��
simulation=100; %�ظ��������

 capacityOfAver=[];


for Lr=1:16
    capacityOfSum=0;
    
    for sim=1:simulation
        H=sqrt(1/2)*(randn(Nr,Ns)+1j*randn(Nr,Ns));%�����ŵ�       
        fullAntenna=[1:Nr];%���������߼���
           H_sel=[];%ѡ��������ŵ�����   
 

 for n=1:Lr    %ѭ��һ��ѡ���һ������     
  randomIndex=randint(1,1,[1,length( fullAntenna)]);
  H_sel=[H_sel;H(randomIndex,:)];%��ѡ�����ߵ��ŵ�
  fullAntenna(randomIndex)=[]; %ȥ���ѱ�ѡ�������     
 end

            capacityOfSelected=log2(det(eye(Ns)+SNR/Ns*(H_sel'*H_sel))) ; %ѡ�����ŵ�����
          
             capacityOfSum=capacityOfSum+capacityOfSelected;%�ŵ������ۼ�ֵ    

    end
      capacityOfAver=[capacityOfAver,capacityOfSum/simulation];
      
end


X=[0:16];
plot(X,[0,capacityOfAver]);
xlabel('Lr');
ylabel('capacity(bit/s/Hz)');
grid on;