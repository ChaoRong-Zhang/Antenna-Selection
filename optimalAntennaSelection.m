Ns=4; %��������
Nr=16;%��������
SNR=6;%dB
SNR= 10^(SNR/10); %dBת��SNR������ȣ���λΪdB)=10 lg��S/N)����һ�£�S/N=10^(SNR/10��
simulation=10; %�ظ��������

 capacityOfAver=[];


for Lr=1:16
    capacityOfSum=0;
      antennaSubset=nchoosek([1:Nr],Lr);%���п��ܵ������Ӽ�
    
    for sim=1:simulation
        H=sqrt(1/2)*(randn(Nr,Ns)+1j*randn(Nr,Ns));%�����ŵ�       
        fullAntenna=[1:Nr];%���������߼���
     
%      capacityOfSubsetMax=0;%��¼ѡ��������ΪLrʱ�����Ӽ��������ŵ�����
%      
%      for k=1:nchoosek(Nr,Lr) %ѡ��������ΪLr��ѭ��һ�β���һ���Ӽ����ŵ�����������nchoosek(Nr,Lr)���Ӽ���
%                indexOfChannel=antennaSubset(k,:);%һ���Ӽ�                        
%                H_sel=H(indexOfChannel,:);%ѡ��������ŵ�����
%                capacityOfSubset=log2(det(eye(Ns)+SNR/Ns*(H_sel'*H_sel))) ; %�Ӽ�������
%           
%                if(capacityOfSubset>capacityOfSubsetMax)%�����Ӽ��������ŵ�����
%                    capacityOfSubsetMax=capacityOfSubset;
%                end
%      end
              
          capacityOfSum=capacityOfSum+ capacityOfSubsetMax;%�ŵ������ۼ�ֵ  
      
    end    
      capacityOfAver=[capacityOfAver,capacityOfSum/simulation];
      
end


X=[0:16];
plot(X,[0,capacityOfAver]);
xlabel('Lr');
ylabel('capacity(bit/s/Hz)');
grid on;
hold on;