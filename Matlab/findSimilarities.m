function [ output_args ] = findSimilarities( A, B )

    v = size(A, 1);

    % Find all subgraphs that are copaths.
    aHashes = [];
    for i = 1 : v
        aHashes = horzcat(aHashes, {DataHash(sortrows(generateKs(subgraph(A,i),(v-1)*2)))});
    end

    bHashes = [];
    for i = 1 : v
        bHashes = horzcat(bHashes, {DataHash(sortrows(generateKs(subgraph(B,i),(v-1)*2)))});
    end

    % Find all subgraphs that are copaths.
    similarities = [];
    for i = 1 : v
        aHash = cell2mat(aHashes(i));
        for j = 1 : v
            bHash = cell2mat(bHashes(j));
            if (strcmp(aHash, bHash))
                similarities = horzcat(similarities, [i;j]);
            end
        end
    end

    output_args = similarities;
end

