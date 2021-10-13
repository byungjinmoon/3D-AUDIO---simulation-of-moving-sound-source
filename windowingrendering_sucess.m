clear all; close all;
%%  window design
Nfft = 199*2;
hNfft = Nfft/2;
tt = [0:100000-1]/Nfft;
cosine = cos(2*pi*tt);
cos1 = cosine;
%% window ���
a0 = (1+ sqrt(2)) /4;
a1 = (1+ sqrt((5-2* sqrt(2)) /2)) /4;
a2 = (1- sqrt(2)) /4;
a3 = (1- sqrt((5-2* sqrt(2)) /2)) /4;
%% fade out
for n=1:hNfft
    ft = a0 + a1 * cos1(n) + a2*cos1(2*n) + a3*cos1(3*n);
    ft_vec(n) = ft;
end
ft_vec=ft_vec';
%% fade in 
for n=1:hNfft
    gt = a0 - a1 * cos1(n) + a2*cos1(2*n) - a3*cos1(3*n);
    gt_vec(n) = gt;
end
gt_vec=gt_vec';
%% window plot


% figure,
% plot(gt_vec)
% figure,
% plot(ft_vec)

%% fast convolution HRIR switching

[speech,Fs] = audioread('home.mp3');%load music or speech
load('large_pinna_frontal');%load HRTF 
speech1=speech(1:Fs*11,1);%���� ä�� 11�ʱ��� �ڸ�
speech2=speech(1:Fs*11,1);%������ ä�� 11 �ʱ��� �ڸ�

speech=(speech1+speech2)/sqrt(2);



nfft=512;
L=313;
delay=512-313;
filter_output_L =zeros(length(speech)+200-1,1);%�� ��°� ���� ����� overlap�ϱ����� ����.
filter_output_R =zeros(length(speech)+200-1,1);

m=1;%impulse response ��ġ
p=1;%�� 1�� ������ impulseresponse�� �̵������ֱ����� ����
%���ʱͿ� �鸮�¼Ҹ�
for i =1:L:fix(length(speech)-L)

    if i==44133*p+1
        p=p+1;
        h_L=left(:,m);
        H_L=fft(h_L,nfft);
        y_tmp_fout1=ifft((fft(speech(i-L:i-1),nfft).*H_L),nfft);%y(k-1)_A(n)�� M-1
        y_tmp_fout2=ifft((fft(speech(i:i+L-1),nfft).*H_L),nfft);%y(k)_A(n)�� M-1
        y_tmp_fout=ft_vec(1:delay).*(y_tmp_fout1(L+1:nfft)+y_tmp_fout2(1:nfft-L));% fade out(M-1)
      
        
        m=m+9;%impulse response change
        h_L=left(:,m);
        H_L=fft(h_L,nfft);
        y_tmp_fin1=ifft((fft(speech(i-L:i-1),nfft).*H_L),nfft);%y(k-1)_B(n)�� (M-1)
        tmp_y=ifft(fft(speech(i:i+L-1),nfft).*H_L,nfft);%y(k)_B(n)
        y_tmp_fin=gt_vec(1:delay).*(y_tmp_fin1(L+1:nfft)+tmp_y(1:nfft-L));%fade in
        
        filter_output_L(i:i+nfft-1) = filter_output_L(i:i+nfft-1)+tmp_y(1:nfft);%�� ��°� ���� ����� overlap
        filter_output_L(i:i+nfft-L-1)=y_tmp_fout+y_tmp_fin;%fadein fadeout �κ� ����.
        y_k_L(i:i+L-1)=filter_output_L(i:i+L-1);
    
   else  
        h_L=left(:,m);
        H_L=fft(h_L,nfft);
        tmp_y=ifft(fft(speech(i:i+L-1),nfft).*H_L,nfft);%%�����Է°� ���� impulse response�� ���.
        filter_output_L(i:i+nfft-1) = filter_output_L(i:i+nfft-1)+tmp_y(1:nfft);%�� ��°� tmp_y���� overlap �� �� ��� ���� ����.
        y_k_L(i:i+L-1)=filter_output_L(i:i+L-1);
   end
 
end
m=1;
p=1;
%�����ʱͿ� �鸮�¼Ҹ�
for i =1:L:fix(length(speech)-L)
   
   if i==44133*p+1
        p=p+1;
        h_L=right(:,m);
        H_L=fft(h_L,nfft);
        y_tmp_fout1=ifft((fft(speech(i-L:i-1),nfft).*H_L),nfft);%y(k-1)_A(n)�� M-1
        y_tmp_fout2=ifft((fft(speech(i:i+L-1),nfft).*H_L),nfft);%y(k)_A(n)�� M-1
        y_tmp_fout=ft_vec(1:delay).*(y_tmp_fout1(L+1:nfft)+y_tmp_fout2(1:nfft-L));% fade out(M-1)
         
        
        
        
        m=m+9;%impulse response change
        h_L=right(:,m);
        H_L=fft(h_L,nfft);
        y_tmp_fin1=ifft((fft(speech(i-L:i-1),nfft).*H_L),nfft);%y(k-1)_B(n)�� (M-1)
        tmp_y=ifft(fft(speech(i:i+L-1),nfft).*H_L,nfft);%y(k)_B(n)
        y_tmp_fin=gt_vec(1:delay).*(y_tmp_fin1(L+1:nfft)+tmp_y(1:nfft-L));%fade in
        
        filter_output_R(i:i+nfft-1) = filter_output_R(i:i+nfft-1)+tmp_y(1:nfft);%�� ��°� ���� ����� overlap
        filter_output_R(i:i+nfft-L-1)=y_tmp_fout+y_tmp_fin;%fadein fadeout �κ� ����.
        y_k_R(i:i+L-1)=filter_output_R(i:i+L-1);
    
   else  
        h_L=right(:,m);
        H_L=fft(h_L,nfft);
        tmp_y=ifft(fft(speech(i:i+L-1),nfft).*H_L,nfft);%%�����Է°� ���� impulse response�� ���.
        filter_output_R(i:i+nfft-1) = filter_output_R(i:i+nfft-1)+tmp_y(1:nfft);%�� ��°� tmp_y���� overlap �� �� ��� ���� ����.
        y_k_R(i:i+L-1)=filter_output_R(i:i+L-1);
   end
   
end



  
Moving_sound=[y_k_L',y_k_R'];
sound(Moving_sound,44100); 

%  N=length(speech2);
%  t=[0:N-1]./N *(N/Fs);
%  t_2=find(t==10);
%  t2=(1:t_2);
% output_frequency_L=y_k_L;
% out_frequency=output_frequency_L(1:t_2);
% 
% figure
% plot( t(1:t_2),out_frequency);
% filename='fast_convolution_windowing.wav';
% audiowrite(filename,Moving_sound,Fs);
