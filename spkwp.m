clc
%import data rating kecocokan dari masing-masing alternatif
opts = detectImportOptions('Real estate valuation data set_edited2.xlsx');
opts.SelectedVariableNames = (1:4);
data = readmatrix('Real estate valuation data set_edited2.xlsx', opts);
%atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
k = [0,0,1,0];
%Nilai bobot tiap kriteria (1= sangat buruk, 2=buruk, 3= cukup, 4= tinggi, 5= sangat tinggi)
w = [3,5,4,1];
%tahapan pertama, perbaikan bobot
[m n]=size (data); %inisialisasi ukuran data
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot
%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n
    if k(j)==0, w(j)=-1*w(j);
    end
end
for i=1:m
    
    S(i)=prod(data(i,:).^w);
end
%tahapan ketiga, proses perangkingan
V= S/sum(S)

%pengurutan data
Vsorted = sort(V, 'descend')

