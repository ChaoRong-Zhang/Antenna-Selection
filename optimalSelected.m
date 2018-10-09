function  capacityOfSubsetMax=optimalSelected(Nr,Ns,Lr,SNR,H,antennaSubset)

    
    capacityOfSubsetMax=0;%��¼ѡ��������ΪLrʱ�����Ӽ��������ŵ�����
    
    for k=1:nchoosek(Nr,Lr) %ѡ��������ΪLr��ѭ��һ�β���һ���Ӽ����ŵ�����������nchoosek(Nr,Lr)���Ӽ���
        indexOfChannel=antennaSubset(k,:);%һ���Ӽ�
        H_sel=H(indexOfChannel,:);%ѡ��������ŵ�����
        capacityOfSubset=log2(det(eye(Ns)+SNR/Ns*(H_sel'*H_sel))) ; %�Ӽ�������
        
        if(capacityOfSubset>capacityOfSubsetMax)%�����Ӽ��������ŵ�����
            capacityOfSubsetMax=capacityOfSubset;
        end
    end
