function  capacityOfSelected=gorokohovSelected(Nr,Ns,Lr,SNR,H,fullAntenna);
if(Lr==Nr)
    capacityOfSelected=log2(det(eye(Ns)+SNR/Ns*(H'*H))) ;
else
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
end