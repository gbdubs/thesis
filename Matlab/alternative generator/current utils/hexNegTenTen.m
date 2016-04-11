function [ hex ] = hexNegTenTen( score )
    
    i = ceil((score + 10) / 20 * 63);

    if (i <= 32)
        rgb = [1, 1 - (32 - i) / 32, 1 - (32 - i) / 32];
    else
        rgb = [1 - (i-32) / 32, 1 - (i-32) / 32, 1];
    end
    
    rgb = round(rgb*255); 
    
    hex(:,1:6) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
    
    
    
end

