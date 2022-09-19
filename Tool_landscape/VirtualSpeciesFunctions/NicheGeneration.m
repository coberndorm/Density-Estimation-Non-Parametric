function MapInfo = NicheGeneration(ReadInfo, InfoInitialPoint, Occupation, show)
% MapInfo = NicheGeneration(ReadInfo, InfoInitialPoint, Occupation, show)
% 
% DESCRIPTION
%   
% 
% REQUIRED INPUTS
%   ReadInfo: an structure generated by 'ReadLayers' function
%   InfoInitialPoint: an structure generated by 'InitialPoint' function
%   Occupation: an integer with the occupation value ([0,1))
%   show: boolean variable (true, false) to show the resulting niche map  
%         for the virtual species 
% 
% OUTPUTS
%   %MapInfo:
%       -Map:
%       -SortNormDistance:
%       -NormDistance:
%%        

    %Reading climate variables

    Indicator = ReadInfo.Indicator;
    Dimension = ReadInfo.Dimensions(1);
    R = ReadInfo.R;
    [Dim1, Dim2] = size(ReadInfo.Map);
    Map = nan(Dim1, Dim2);
        
    idx = InfoInitialPoint.idx;
    SortNormDistance = InfoInitialPoint.SortNormDistance;
    
    limit = round(Dimension * Occupation); 
    
    NormDistance = zeros(1,length(SortNormDistance));
    SortNormDistance(limit : end) = 0;
    
    IndexSortNorm = 1 : limit - 1;
    SortNormDistance(IndexSortNorm) = normalize(SortNormDistance(IndexSortNorm), 2, 'range');
    

    NormDistance(idx) = SortNormDistance;
    Map(~Indicator) = NormDistance;
    
    %Plot niche map
    if show == 1
        clf
        geoshow(Map, R, 'DisplayType', 'surface');
        contourcmap('jet', 0 : 0.05 : 1, 'colorbar', 'on', 'location', 'vertical')
    end
    
    % OUTPUT STORAGE 
    MapInfo.Map = Map;
    MapInfo.SortNormDistance = SortNormDistance;
    MapInfo.NormDistance = NormDistance;
      
end
