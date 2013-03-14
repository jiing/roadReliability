function monteCarloMethod()
MC_counter=0
true_counter =0
false_counter=0

for ix=1:20
    if(roadReliability == 1)
        true_counter = true_counter+1;
    else
        false_counter = false_counter+1;
    end    
    
end


true_counter;
false_counter;
figure(2)

pie3([true_counter false_counter], [1 1], ...
    {['Success:',num2str(true_counter/(true_counter+false_counter)*100),'%'],...
    ['Fail:',num2str(false_counter/(true_counter+false_counter)*100),'%']})
title(['Monte Carlo Simulation: # of Total Runs=', num2str(true_counter+false_counter)])


