function [ result ] = PQRC( graphSet )
    [~, ~, ~, result, ~] = ADSR_PQRA_PQRB_PQRC_ODSPL(graphSet);
end