function exploremap(long,lat,elev)
%EXPLOREMAP Creates an interactive map to explore
% This function will take in the data given by the three arrays, X, Y, and
% Z. They must all be arrays of the same dimensions. It will then plot the
% contour map and a surface map and will allow the user to move about the
% contour map using the WASD keys. The user will quit using the Q key. The
% boundary box should not extend beyond the map edges

%{
Sitong Ju
ITP 168 Spring 2019
Homework 9
sitongju@usc.edu
%}

% validate the inputs: numeric array, sizes of input should be same
if isnumeric(long) == 0|isnumeric(lat) == 0 | isnumeric(elev) == 0
    error('The inputs should be numeric')
elseif isscalar(long) == 1| isscalar(lat)== 1|isscalar(elev) == 1
    error('The inputs should be array')
elseif size(long) ~= size(lat)|size(long)~= size(elev)
    error('The inputs should have same size')
end


% convert the latitude and longitude into meters
radiusOfEarth = 6371000;
[nrow,ncol] = size(long);
longMeters = zeros(nrow,ncol);
latMeters = zeros(nrow,ncol);
for index = 2:ncol
    longMeters(:,index) = longMeters(:,index - 1) + radiusOfEarth.*tand(long(:,index) - long(:,index-1));
end
for index = 2:nrow
    latMeters(index,:) = latMeters(index - 1,:) + radiusOfEarth.*tand(lat(index,:) - lat(index-1,:));
end

% plot the second subplot first
subplot(1,2,2);
contour(longMeters,latMeters,elev);

% plot the boundary box
hold on;
bsize = 30;
rs = 1;
cs = 1;
re = rs+bsize;
ce = cs+bsize;
phandle = plot(longMeters(rs,cs:ce),latMeters(rs,cs:ce),'r',longMeters(re,cs:ce),latMeters(re,cs:ce),'r',longMeters(rs:re,cs),latMeters(rs:re,cs),'r',longMeters(rs:re,ce),latMeters(rs:re,ce),'r');
axis equal
hold off;

% using xlima and ylim to plot the first plot: surface plot
subplot(1,2,1);
surf(longMeters,latMeters,elev);
xlim(longMeters(re,[cs,ce]));
ylim(latMeters([re,rs],cs));

% set the moving step
ms = 5;

%% don't touch this stuff
set(gcf,'KeyPressFcn',@callback);
set(gcf,'CurrentCharacter','n');
choose = 'n';
while (choose ~= 'q')
    choose = get(gcf,'CurrentCharacter');
    switch choose
        case 's' %the user wants to move south
            %% TODO: WRITE CODE HERE
            % update the box on the contour plot
            rs = rs+ms;
            re = re+ms;
            if re > nrow %don't allow the to go beyond the contour plot
                rs = nrow-bsize;
                re = nrow;
            end
            % update the box plot
            phandle(1).XData = longMeters(rs,cs:ce);
            phandle(1).YData = latMeters(rs,cs:ce);
            phandle(2).XData = longMeters(re,cs:ce);
            phandle(2).YData = latMeters(re,cs:ce);
            phandle(3).XData = longMeters(rs:re,cs);
            phandle(3).YData = latMeters(rs:re,cs);
            phandle(4).XData = longMeters(rs:re,ce);
            phandle(4).YData = latMeters(rs:re,ce);            
            %% stop writing code here
        case 'w' %the user wants to move north
            %% TODO: WRITE CODE HERE
            rs = rs-ms;
            re = re-ms;
            if rs < 1
                rs = 1;
                re = 1+bsize;
            end
            phandle(1).XData = longMeters(rs,cs:ce);
            phandle(1).YData = latMeters(rs,cs:ce);
            phandle(2).XData = longMeters(re,cs:ce);
            phandle(2).YData = latMeters(re,cs:ce);
            phandle(3).XData = longMeters(rs:re,cs);
            phandle(3).YData = latMeters(rs:re,cs);
            phandle(4).XData = longMeters(rs:re,ce);
            phandle(4).YData = latMeters(rs:re,ce);
            
            %% stop writing code here
        case 'a' %the user wants to move west
            %% TODO: WRITE CODE HERE
            cs = cs-ms;
            ce = ce-ms;
            if cs < 1
                cs = 1;
                ce = 1+bsize;
            end
            phandle(1).XData = longMeters(rs,cs:ce);
            phandle(1).YData = latMeters(rs,cs:ce);
            phandle(2).XData = longMeters(re,cs:ce);
            phandle(2).YData = latMeters(re,cs:ce);
            phandle(3).XData = longMeters(rs:re,cs);
            phandle(3).YData = latMeters(rs:re,cs);
            phandle(4).XData = longMeters(rs:re,ce);
            phandle(4).YData = latMeters(rs:re,ce);
            %% stop writing code here
        case 'd' %the user wants to move east
            %% TODO: WRITE CODE HERE
            cs = cs+ms;
            ce = ce+ms;
            if ce > ncol
                cs = ncol-bsize;
                ce = ncol;
            end
            phandle(1).XData = longMeters(rs,cs:ce);
            phandle(1).YData = latMeters(rs,cs:ce);
            phandle(2).XData = longMeters(re,cs:ce);
            phandle(2).YData = latMeters(re,cs:ce);
            phandle(3).XData = longMeters(rs:re,cs);
            phandle(3).YData = latMeters(rs:re,cs);
            phandle(4).XData = longMeters(rs:re,ce);
            phandle(4).YData = latMeters(rs:re,ce);
            
            %% stop writing code here
        case 'q'
            %user quits
            break;
    end
    set(gcf,'CurrentCharacter','n');
    %% TODO: WRITE CODE HERE
    % update the surface plot
    subplot(1,2,1);
 
    xlim(longMeters(re,[cs,ce]));
    ylim(latMeters([re,rs],cs));
    
    %% stop writing code here
    pause(0.1);
end
end

%% don't touch any of this.
function callback(hObject, callbackdata)

end