function rc = s2rc( s , colCount )
% helper utility to convert state to rows + columns
    rc(1) = ceil( s / colCount );
    rc(2) = s - ( rc(1) - 1 ) * colCount;