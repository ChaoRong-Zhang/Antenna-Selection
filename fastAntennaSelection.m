close all;
clear all;
format long; 

Ns=4; %��������
Nr=16;%��������
SNR=6;%dB
SNR= 10^(SNR/10); %dBת��SNR������ȣ���λΪdB)=10 lg��S/N)����һ�£�S/N=10^(SNR/10��
simulation=100; %�ظ��������

 capacityOfAver=[];


for Lr=1:16
    capacityOfSum=0;
    
    for sim=1:simulation
        H=sqrt(1/2)*(randn(Nr,Ns)+1j*randn(Nr,Ns));%�����ŵ�       
        fullAntenna=[1:Nr];%���������߼���
        
        B=eye(Ns,Ns);%��ʼ��B   
        Alpha=[];
        H_sel=[];%ѡ��������ŵ�����       
      
        for j=1:Nr   %��ʼ��Alpha
            f=H(j,:);
            h=f';
            alpha=h'*h;%����
            Alpha=[Alpha alpha]; %��¼ÿһ�ε�alpha
        end
        
        for n=1:Lr    %ѭ��һ��ѡ���һ������
            [maxOfAlpha,index]=max(Alpha);  %ѡ�����J��Ӧ������
           
            fullAntenna(index)=[]; %ȥ���ѱ�ѡ�������                
            H_sel=[H_sel;H(index,:)];%��ѡ�����ߵ��ŵ�
            
             if (n<Lr)
                f=H(index,:);
                h=f';
                alpha=Alpha(index);              
                a=(B*h)/sqrt((Ns/SNR)+alpha);
                B=B-a*a';                     %B����
               
                Alpha(index)=[];%ȥ���ѱ�ѡ�����߶�Ӧ��alpha
                       
                 for k=1:length( fullAntenna)
                    Alpha(k)=Alpha(k)-(abs(a'*h))^2;   %alpha����
                 end      
                 
             end
            
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
hold on;