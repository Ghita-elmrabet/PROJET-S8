function [n]=zero_crossing(signal)
    n1=0;
    n2=0;
    for j=1:length(signal)-1
        if (signal(j)*signal(j+1)<0)
            n1=n1+1;
        end
    end
    for j=1:length(signal)
        if signal(j)==0
            n2=n2+1;
        end    
    end
    n=n1+n2;
end