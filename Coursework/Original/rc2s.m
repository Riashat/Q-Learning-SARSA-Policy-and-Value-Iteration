function s = rc2s( rc , colCount )
% helper utility to convert rows + columns to s
    s = ( rc(1) - 1 ) * colCount + rc(2);