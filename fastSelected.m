function  capacityOfSelected=fastSelected(Nr,Ns,Lr,SNR,H,fullAntenna);
if(Lr==Nr)
    capacityOfSelected=log2(det(eye(Ns)+SNR/Ns*(H'*H))) ;
else
    
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
end