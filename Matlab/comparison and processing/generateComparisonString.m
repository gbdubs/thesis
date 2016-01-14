function [output_args] = generateComparisonString( A, B )
    
    result = 'COMPARING TWO GRAPHS\n\n\nSUBGRAPH EQUALITIES\n\n';

    subgraphEqualities = findSubgraphQuaziEqualities(A, B);
    
    result = strcat(result, mat2str(subgraphEqualities));
    result = strcat(result,'\n\n\nA QUAZI EQUIVALENCE CLASSES\n\n');
    
    aEquivClasses = findQuaziEquivalenceClasses(A);
    
    result = strcat(result, equivalenceClassesToString(aEquivClasses));
    result = strcat(result, '\n\n\nB QUAZI EQUIVALENCE CLASSES\n\n');
    
    bEquivClasses = findQuaziEquivalenceClasses(B);
    result = strcat(result, equivalenceClassesToString(bEquivClasses));
    
    output_args = strrep(result, ';', '\n');
    
end

