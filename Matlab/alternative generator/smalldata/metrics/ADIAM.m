function [ result ] = ADIAM(graphSet)
    [~, ~, ~, result, ~] = PCONN_ANCC_NCCV_ADIAM_DIAMV(graphSet);
end