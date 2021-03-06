function CA=fast_CA3(CA, current_row)

global temp
global temp_size
global to_check_list
global total_count
global checked_list

%temp_size
%current_row
%temp

[size_r, size_c]=size(temp);
if(total_count > size_r*size_c )
        return
end
total_count = total_count+1;

if ~isempty(to_check_list)
    current_row = to_check_list(1)
else
    return
end

for ix=1:temp_size(current_row,1)
    to_check_list = union(to_check_list, temp{current_row,ix});
end
checked_list(length(checked_list)+1)= current_row

%to_check_list
if ~isempty(to_check_list)
    to_check_list = setdiff(to_check_list, checked_list);
end 

for ix=1:length(checked_list)
    CA{ix,1}= checked_list(ix);  
end
%CA
current_row=1;

CA =fast_CA3(CA, current_row);