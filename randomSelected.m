function  capacityOfSelected=randomSelected(Nr,Ns,Lr,SNR,H,fullAntenna);
if(Lr==Nr)
    capacityOfSelected=log2(det(eye(Ns)+SNR/Ns*(H'*H))) ;
else
    H_sel=[];
    for n=1:Lr    %ѭ��һ��ѡ���һ������
        randomIndex=randint(1,1,[1,length( fullAntenna)]);
        H_sel=[H_sel;H(randomIndex,:)];%��ѡ�����ߵ��ŵ�
        fullAntenna(randomIndex)=[]; %ȥ���ѱ�ѡ�������
    end
    
    capacityOfSelected=log2(det(eye(Ns)+SNR/Ns*(H_sel'*H_sel))) ; %ѡ�����ŵ�����
end