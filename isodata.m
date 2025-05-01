
function [level,MAT,MBT]=isodata(I)
% ISODATA Compute global image threshold using iterative isodata method.
% LEVEL = ISODATA(I) computes a global threshold (LEVEL) that can be
% used to convert an intensity image to a binary image with IM2BW.

% Converting all N-D arrays into a single column.  Convert to uint8 for fastest histogram computation.
I = im2uint8(I(:));

% STEP 1: Computing mean intensity of image from histogram, set T=mean(I)
[counts,N]=imhist(I);
counts(1)=0;
i=1;
mu=cumsum(counts);
T(i)=(sum(N.*counts))/mu(end);
T(i)=round(T(i));

% STEP 2: computing Mean above T (MAT) and Mean below T (MBT) using T from
mu2=cumsum(counts(1:T(i)));
MBT=sum(N(1:T(i)).*counts(1:T(i)))/mu2(end);

mu3=cumsum(counts(T(i):end));
MAT=sum(N(T(i):end).*counts(T(i):end))/mu3(end);
i=i+1;
T(i)=round((MAT+MBT)/2);

% STEP 3 to n: repeating step 2 if T(i)~=T(i-1)
    while abs(T(i)-T(i-1))>=1
        mu2=cumsum(counts(1:T(i)));
        MBT=sum(N(1:T(i)).*counts(1:T(i)))/mu2(end);

        mu3=cumsum(counts(T(i):end));
        MAT=sum(N(T(i):end).*counts(T(i):end))/mu3(end);

        i=i+1;
        T(i)=round((MAT+MBT)/2); 
        Threshold=T(i);
    end
% Normalizing the threshold to the range [i, 1].
level = (Threshold - 1) / (N(end) - 1);
MAT = MAT / (N(end) - 1);
MBT = MBT / (N(end) - 1);
end

