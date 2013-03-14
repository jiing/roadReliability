function true_or_false = isInCheckedList(current_row)
global checked_list


true_or_false=0;
for ix=1:length(checked_list)
   if checked_list(ix)==current_row
      true_or_false=1;
   end
end