close all;
clear all;
format long;

Ns=4; %��������
Nr=16;%��������
SNR=6;%dB
SNR= 10^(SNR/10); %dBת��SNR������ȣ���λΪdB)=10 lg��S/N)����һ�£�S/N=10^(SNR/10��
simulation=1000; %�ظ��������

capacityOfAver=[];


for Lr=1:16
    capacityOfSum=0;
    
    for sim=1:simulation
        H=sqrt(1/2)*(randn(Nr,Ns)+1j*randn(Nr,Ns));%�����ŵ�
        fullAntenna=[1:Nr];%���������߼���
        
        B=inv(eye(Ns,Ns)+SNR/Ns*(H'*H));%��ʼ��B
        
        
        for n=1:(Nr-Lr)   %��������ѭ��һ������һ�����ߣ����µ�����Ҫ������
            Alpha=[];
            for j=1:length(fullAntenna)   %��ʼ��Alpha
                f=H(j,:);
                h=f';
                alpha=h'*B*h;%����
                Alpha=[Alpha alpha]; %��¼ÿһ�ε�alpha
            end
            [minOfAlpha,index]=min(Alpha);  %ѡ�����J��Ӧ������
            fullAntenna(index)=[]; %����������
            
            if (n<Nr-Lr)
                f=H(index,:);
                h=f';
                alpha=Alpha(index);
                a=B*h;
                B=B+a*a'/(Ns/SNR-alpha);
            end
        end
        H_sel=H(fullAntenna,:);
        
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
hold on;