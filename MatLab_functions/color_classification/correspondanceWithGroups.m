%% Classification of image sent
function correspondanceWithGroups(scores, label)
    kid = [1 4 8 15 22];
    top = [2 3 4 5 6 7 9 10 11 12 13 14 16 17 18 19 20 21];
    bottom = [23 24 25 28 29 30 31 32 33 34];
    underwear = [26 27];
    footwear = [35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50];
    
    label = double(label);
    
    %Message
    message = "Do you agree it is ";
    
    if ismember(label, kid)
        m = "children's clothing";
    elseif ismember(label, top)
        m = "top body clothing";
    elseif ismember(label, bottom)
        m = "lower body clothing";
    elseif ismember(label, underwear)
        m = "underwear";
    elseif ismember(label, footwear)
        m = "footwear";
    else
        m = "mistake";
    end
    
    s = strcat(message, m, " ?");
       
    fileID = fopen('label.txt','w');
    fprintf(fileID, s);
    fclose(fileID);
    
    fileID2 = fopen('labelNum.txt','w');
    fprintf(fileID2,num2str(label));
    fclose(fileID2);
    
end
