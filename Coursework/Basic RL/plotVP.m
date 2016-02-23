function plotVP( Vopt, Popt, paramSet )
% plots v,p on a grid

% this gets rid of the final absorbing state that exists only because of the
% way in which "wall" states are implemented.
Vopt = Vopt(1:end-1);
Popt = Popt(1:end-1);

% normalise range of v and plot on grid, setting values of obstructed cells
% to 0 (so they will show up as off-color blocks)
figure(1); clf;
colormap( gray )
v = Vopt;

for rc = paramSet.obsSet',
    v(rc2s(rc, paramSet.colCount)) = -inf;
end

v = reshape( v , paramSet.colCount, paramSet.rowCount )';
imagesc(v);
hold on;

% loop through policy and plot directions
thetaLUT = [ pi/2 -pi/2 pi 0 ];
for s = 1:( paramSet.rowCount * paramSet.colCount )
    isbad = 0;
    for rc = paramSet.obsSet',
        if s == rc2s(rc, paramSet.colCount),
            isbad = 1;
            break;
        end
    end
    if ~isbad,
        rc = s2rc( s , paramSet.colCount );
        r = rc(1); c = rc(2);
        ang = thetaLUT( Popt( s ) );
        plot( c , r , 'co' );
        plot( [ c (c + .25*cos( ang )) ], ...
              [ r (r - .25*sin( ang )) ], ...
               'c' );
    end
end
    
% plot start and goal
plot( paramSet.goalState(2) , paramSet.goalState(1) , 'rp', 'markersize',20 )
plot( paramSet.startState(2) , paramSet.startState(1) , 'rs', 'markersize',20 )

hold off;

