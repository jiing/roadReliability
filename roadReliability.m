function true_or_false = roadReliability()

close all
clear all
% original structure
load structure.txt
%load structure_11.txt
%structure = structure_11
global temp

%set(0,'RecursionLimit',5000)
structure
%
arc_probability1 = triu(rand(size(structure>0))).*structure

arc_probability2 = triu(rand(size(structure>0))).*structure

%arc_probability = arc_probability0.*(arc_probability0 <= 0.9)

% arc_type 0, 1 , 2 , 3, 
%arc_type = (arc_probability >0).*floor(rand(size(structure))*4)

arc_type= triu(structure.*(floor(rand(size(structure))*4)))

for ix=1:size(arc_type,1)
    for jx=1:size(arc_type,2)
      if(jx > ix)
         if(arc_type(ix,jx) == 1 & arc_probability1(ix,jx)>0.9)
            arc_type(ix,jx)=0;
         elseif(arc_type(ix,jx) == 2 & arc_probability2(ix,jx)>0.9)
            arc_type(ix,jx)=0;
         elseif(arc_type(ix,jx)==3)
             if(arc_probability1(ix,jx)>0.7 & arc_probability2(ix,jx)>0.7)
                arc_type(ix,jx)=0;
                continue;
             elseif arc_probability1(ix,jx)>0.7
                arc_type(ix,jx)=2;
                continue;
             elseif arc_probability2(ix,jx)>0.7
                arc_type(ix,jx)=1;
             end
         end
      end
    end
end

arc_type


% draw network graph

% coordinates for points
% x_y = floor(rand(6,2)*10)
x_y = [1 2
       2 3
       3 3
       2 1
       3 1
       4 2
    ];

%for 11 nodes case
%x_y = [1 2
%    2 3
%    3 3
%    4 3
%    2 2
%    3 2 
%    4 2
%    2 1
%    3 1
%    4 1
%    5 2];

%subplot(2,1,1)
%for ix=1:size(arc_type,1)
%    for jx=1:size(arc_type,2)
%       if(jx > ix & arc_type(ix,jx)>0)
%           plot([ x_y(ix,1) x_y(jx,1)] ,[ x_y(ix,2) x_y(jx,2)], '-' )
%           hold on    
%       end
%    end
%end
%axis off
%title('original network structure')

%subplot(2,1,2)
%draw the arc_type as quiver
for ix=1:size(arc_type,1)
    for jx=1:size(arc_type,2)
        plot([ x_y(ix,1) x_y(jx,1)], [ x_y(ix,2) x_y(jx,2) ],'.')
        hold on
        text([ x_y(ix,1)+0.05 ], [ x_y(ix,2)+0.05 ], num2str(ix) )
      
      if arc_type(ix,jx)==1 
           quiver( x_y(ix,1), x_y(ix,2) , ( x_y(jx,1)-x_y(ix,1) ),( x_y(jx,2)-x_y(ix,2) ) )
      elseif arc_type(ix,jx)==2
           quiver( x_y(jx,1), x_y(jx,2) , ( x_y(ix,1)-x_y(jx,1) ),( x_y(ix,2)-x_y(jx,2) ) )
      elseif arc_type(ix,jx)==3
           quiver( x_y(ix,1), x_y(ix,2) , ( x_y(jx,1)-x_y(ix,1) ),( x_y(jx,2)-x_y(ix,2) ) )
           quiver( x_y(jx,1), x_y(jx,2) , ( x_y(ix,1)-x_y(jx,1) ),( x_y(ix,2)-x_y(jx,2) ) )
      end
    end
end
axis off

for ix=1:size(arc_type,1)
    for jx=1:size(arc_type,2)
       if(jx > ix & arc_probability1(ix,jx)>0 & (arc_type(ix,jx)==1 || arc_type(ix,jx)==3) )
           text([ (x_y(ix,1)+ x_y(jx,1))/2], [ (x_y(ix,2)+ x_y(jx,2))/2 ], ['p1=',num2str(arc_probability1(ix,jx))] )
       elseif(jx > ix & arc_probability2(ix,jx)>0 & (arc_type(ix,jx)==2 || arc_type(ix,jx)==3) )
           text([ (x_y(ix,1)+ x_y(jx,1))/2], [ (x_y(ix,2)+ x_y(jx,2))/2 ], ['p2=',num2str(arc_probability2(ix,jx))] )
       end
    end
end


% calculate if they can go through from pt 1 to pt 6, arc_type = 1 or 3 from
% the beginning by using CA(Cellular Automaton)
global temp
temp={};

for ix=1:size(arc_type,1)
    for jx=1:size(arc_type,2)
        if (arc_type(ix, jx) ==1  )
         temp{ix,length(temp)+1}= jx;
        elseif (arc_type(ix, jx) ==2 )            
         temp{jx,length(temp)+1}= ix;
        elseif(arc_type(ix,jx) == 3)
            temp{ix,length(temp)+1}= jx;
            temp{jx,length(temp)+1}= ix;
        end
    end
end

%a temp for testing
%-------------
%temp={}
%temp{1,1}=4
%temp{3,5}=2
%temp{4,2}=1
%temp{4,6}=2
%temp{4,7}=5
%temp{5,8}=4
%temp{6,9}=5

global new_temp
global size_mat
global checked_list

new_temp={};
size_mat=zeros(length(arc_type),1);

[rows, cols] = size(temp);
for ix=1:rows
    for jx=1:cols
        if(~isempty(temp{ix,jx}))
            size_mat(ix)=size_mat(ix)+1;
            new_temp{ix, size_mat(ix)}= temp{ix,jx};
        end
    end
end


%---------------
%new_temp={}
%new_temp{1,1}=4
%new_temp{4,1}=2
%new_temp{4,2}=5
%new_temp{5,1}=3
%new_temp{5,2}=6
%new_temp{6,1}=5

size_mat=zeros(length(arc_type),1);
[rows, cols] = size(new_temp);

for ix=1:rows
    for jx=1:cols
        if(~isempty(new_temp{ix,jx}))
            size_mat(ix)=size_mat(ix)+1;
        end
    end
end


CA{1,1}=1; %starting point


[rows, cols]=size(temp);
global total_count
total_count=0;
global to_check_list
to_check_list = [1]


CA = fast_CA3(CA, 1)

str='';
for ix=1:length(CA)-1
  tmp=sprintf('%d-',CA{ix});
  str=[str,tmp];
end
  tmp=sprintf('%d',CA{length(CA)});
  str=[str,tmp];

   
if isEndNodeInCA(CA)
    true_or_false = 1
    title({['CA=',str],['Good!']})
else
    true_or_false = 0
    title({['CA=',str],['Bad!']})
end

%graph_idx=floor(rand()*20)
%saveas(gcf,['./roadReliability/g',num2str(graph_idx),'.jpg'])







