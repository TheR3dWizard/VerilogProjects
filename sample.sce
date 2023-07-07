funcprot(0);
function [a0,A,B]=fourier(LTerm,nTerms,func)
    clf();
    a0=1/LTerm*intg(-LTerm,LTerm,func,.000000001);
    for i=1:nTerms
        function cosT=cosTF(x,func)
            cosT=func(x)cos(i%pi*x/LTerm);
        endfunction
        function sinT=sinTF(x,func)
            sinT=func(x)sin(i%pi*x/LTerm);
        endfunction
        A(i)=1/LTerm*intg(-LTerm,LTerm,cosTF,.000000001);
        B(i)=1/LTerm*intg(-LTerm,LTerm,sinTF,.000000001);
    end
    function series=solution(x)
        series=a0/2;
        for i=1:nTerms
            series=series+A(i)cos(i%pi*x/LTerm)+B(i)sin(i%pi*x/LTerm);
        end
    endfunction
    x=-2*LTerm:0.1:2*LTerm;
    plot(x,solution(x));
endfunction
